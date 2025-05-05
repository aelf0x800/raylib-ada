#!/bin/sh
gnatmake example.adb
gnatlink example.ali raylib-5.5_linux_amd64/lib/libraylib.a -lm
rm raylib.ali raylib.o example.ali example.o
