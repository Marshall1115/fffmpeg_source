#!/bin/bash
NDK="/usr/marshall/ndk/android-ndk-r10e"
SYSROOT=$NDK/platforms/android-9/arch-arm/
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64

CPU=arm
PREFIX=$(pwd)/android/$CPU
ADDI_CFLAGS="-marm -I$(pwd)/fdkaac/include -I$(pwd)/x264/include  -DANDROID"
ADDI_LDFLAGS="-L$(pwd)/fdkaac/lib -L$(pwd)/x264/lib"

echo $ADDI_CFLAGS

function build_one
{
./configure --prefix=$PREFIX \
		--disable-static \
		--enable-shared \
		--disable-debug \
                --disable-doc \
                --disable-ffplay \
                --disable-ffprobe \
                --disable-ffserver \
                --disable-avdevice \
                --disable-doc \
                --disable-symver \
                --disable-encoders  \
                --disable-muxers \
                --disable-demuxers \
                --disable-parsers  \
                --disable-bsfs \
                --disable-protocols \
                --disable-indevs \
                --disable-outdevs \
                --disable-filters \
                --disable-decoders \
		--enable-small \
                --enable-asm \
		--enable-nonfree \
                --enable-neon \
		--enable-gpl \
		--enable-muxer=rawvideo  \
		--enable-encoder=rawvideo  \
                --enable-libx264 \
                --enable-encoder=libx264 \
		--enable-encoder=libfdk_aac \
                --enable-decoder=libfdk_aac \
                --enable-libfdk-aac \
		--enable-demuxer=aac \
		--disable-encoder=libfaac \
		--enable-protocol=file \
                --enable-muxer=mp4  \
		--cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
		--target-os=android \
		--arch=arm \
                --disable-libfaac \
		--enable-cross-compile \
		--sysroot=$SYSROOT \
		--extra-cflags="-Os -fpic $ADDI_CFLAGS -mfpu=neon" \
		--extra-ldflags="$ADDI_LDFLAGS" \
                $ADDITIONAL_CONFIGURE_FLAG
make install
}
build_one
