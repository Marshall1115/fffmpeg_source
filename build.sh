#!/bin/bash
make clean


./configure --disable-yasm \
--enable-ffplay \
--disable-stripping \
--disable-asm \
--enable-debug \
--disable-optimizations

make -j8
make install
