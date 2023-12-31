ARCH=arm
CROSS_ROOT=/usr/bin
CROSS_TRIPLET=${ARCH}-linux-gnueabihf
CROSS=${CROSS_ROOT}/${CROSS_TRIPLET}-

CC=${CROSS}gcc
USERCC=${CROSS}gcc
AR=${CROSS}ar
RANLIB=${CROSS}ranlib
CC_AR=${AR} -r ${LIBAR}
PARTIALLD=${CROSS}ld -r --whole-archive

ONELIB=0
OSTYPE=gnulinux
PICFLAGS=-fPIC -fpic
CFLAGS+=${PICFLAGS} -std=c99 -Wformat=0 -Wunused-variable -Wimplicit-function-declaration
LDFLAGS+=-ldl -pthread -lutil
CC_LIB=${CC} -shared -o
CFLAGS_INCLUDE=-I
LDFLAGS_LINK=-l
LDFLAGS_LINKPATH=-L
CFLAGS_OPT0=-O0
CFLAGS_OPT1=-O1
CFLAGS_OPT2=-O2
CFLAGS_OPT3=-O3
CFLAGS_DEBUG=-g
