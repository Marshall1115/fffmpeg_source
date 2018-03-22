#!/bin/bash
make clean


./configure --disable-yasm \
--enable-ffplay \
--enable-debug 
 

make 

