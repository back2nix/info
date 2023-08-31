### Easy path

- sys/meson.py --prefix=/usr --shared

### Succes try

- 
```
sudo -H pip3 install --force-reinstall ninja meson
sudo -H pip3 install --force-reinstall ninja meson==0.44.1
```

##### ubuntu-armhf.txt
```
[binaries]
# we could set exe_wrapper = qemu-arm-static but to test the case
# when cross compiled binaries can't be run we don't do that
c = '/usr/bin/arm-linux-gnueabihf-gcc'
cpp = '/usr/bin/arm-linux-gnueabihf-g++'
rust = ['rustc', '--target', 'arm-unknown-linux-gnueabihf', '-C', 'linker=/usr/bin/arm-linux-gnueabihf-gcc-7']
ar = '/usr/arm-linux-gnueabihf/bin/ar'
strip = '/usr/arm-linux-gnueabihf/bin/strip'
pkgconfig = '/usr/bin/arm-linux-gnueabihf-pkg-config'
ld = '/usr/bin/arm-linux/gnueabihf-ld'

[built-in options]
# Used in unit test '140 get define'
c_args = ['-DMESON_TEST_ISSUE_1665=1']
cpp_args = '-DMESON_TEST_ISSUE_1665=1'

[properties]
root = '/usr/arm-linux-gnueabihf'

has_function_printf = true
has_function_hfkerhisadf = false

skip_sanity_check = true

[host_machine]
system = 'linux'
cpu_family = 'arm'
cpu = 'armv7' # Not sure if correct.
endian = 'little'
```

```
git clone https://github.com/radareorg/radare2
cd radare2
meson builddir/ --cross-file ubuntu-armhf.txt
cd builddir/
meson compile
```


#### Компиляция armv7

~/bin/dockcross make

radare2 hash commit: 9cba1d8714a993bca9a0881937ffe351649edc42

- https://github.com/radareorg/radare2/blob/master/doc/crosscompile

- https://github.com/dockcross/dockcross

#### Не удачная попытка

I followed the instructions

https://github.com/radareorg/radare2/blob/master/doc/crosscompile
and
https://github.com/dockcross/dockcross

just changed to armv7

make clean
docker run --rm dockcross/linux-armv7 > ~/bin/dockcross
sudo chmod +x ~/bin/dockcross
~/bin/dockcross --image thewtex/cross-compiler-linux-armv7 ./configure --with-compiler=armel --host=armel
~/bin/dockcross --image thewtex/cross-compiler-linux-armv7 make
~/bin/dockcross make

- create file in folder radare2/mk
- mk/arm-linux-gnueabi-gcc.mk
- mk/arm-linux-gnueabihf-gcc.mk
```
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
```

