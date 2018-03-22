#!/bin/bash
make clean
#Change NDK to your Android NDK location
NDK=/usr/marshall/ndk/android-ndk-r10e
PLATFORM=$NDK/platforms/android-9/arch-arm/
PREBUILT=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64

GENERAL="\
--enable-small \
--enable-cross-compile \
--extra-libs="-lgcc" \
--arch=arm \
--cc=$PREBUILT/bin/arm-linux-androideabi-gcc \
--cross-prefix=$PREBUILT/bin/arm-linux-androideabi- \
--nm=$PREBUILT/bin/arm-linux-androideabi-nm \
--extra-cflags="-I$(pwd)/fdkacc/include/ -I$(pwd)/x264/include/ -DANDROID" \
--extra-ldflags="-L$(pwd)/x264/lib -L$(pwd)/fdkacc/lib" "

MODULES="\
--enable-gpl \
--enable-libx264"

function build_ARMv6
{
  ./configure \
  --target-os=linux \
  --prefix=$(pwd)/android/armeabi \
  ${GENERAL} \
  --sysroot=$PLATFORM \
  --enable-shared \
  --disable-static \
  --extra-cflags=" -O3 -fpic -fasm -Wno-psabi -fno-short-enums -fno-strict-aliasing -finline-limit=300 -mfloat-abi=softfp -mfpu=vfp -marm -march=armv6" \
  --extra-ldflags="-lx264 -lfdk-aac -Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog" \
  --enable-nonfree \
  --enable-encoder=libfdk_aac \
  --enable-decoder=libfdk_aac \
  --enable-libfdk-aac \
  --enable-demuxer=aac \
  --disable-encoder=libfaac \
  --enable-zlib \
  ${MODULES} \
  --disable-doc \
  --enable-neon \
$ADDITIONAL_CONFIGURE_FLAG
  make clean
  make -j12
  make install
}



build_ARMv6

echo Android ARMEABI builds finished
