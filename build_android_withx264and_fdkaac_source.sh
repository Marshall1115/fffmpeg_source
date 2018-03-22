export NDK=/usr/marshall/ndk/android-ndk-r10e
export SYSROOT=$NDK/platforms/android-9/arch-arm/
export TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.8/prebuilt/linux-x86_64
export CPU=arm
export PREFIX=$(pwd)/android/$CPU
export ADDI_CFLAGS="-marm -I$(pwd)/x264/include/ -I$(pwd)/fdkacc/include/  -DANDROID"
export ADDI_LDFLAGS="-L$(pwd)/x264/lib/ -L$(pwd)/fdkacc/lib/"

echo $ADDI_LDFLAGS


./configure --target-os=linux \
--prefix=$PREFIX --arch=arm \
--disable-doc \
--enable-shared \
--disable-static \
--disable-yasm \
--disable-symver \
--enable-gpl \
--disable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-ffserver \
--disable-doc \
--disable-symver \
--enable-cross-compile \
--extra-libs="-lgcc" \
--cc=$TOOLCHAIN/bin/arm-linux-androideabi-gcc \
--cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
--sysroot=$SYSROOT \
--extra-cflags="-Os -fpic $ADDI_CFLAGS  -fasm -Wno-psabi -fno-short-enums -fno-strict-aliasing -finline-limit=300 -mfloat-abi=softfp -mfpu=vfp" \
--extra-ldflags="$ADDI_LDFLAGS -lx264 -lfdk-aac" \
--enable-muxer=rawvideo \
--enable-nonfree \
--enable-gpl \
--enable-libx264 \
--enable-encoder=libx264 \
--enable-encoder=libfdk_aac \
--enable-decoder=libfdk_aac \
--enable-libfdk-aac \
--enable-demuxer=aac \
--disable-encoder=libfaac \
$ADDITIONAL_CONFIGURE_FLAG
make clean
make -j4
make install




