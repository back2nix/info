### profile

##### ~/.conan/profiles/armv7
```
toolchain=arm-linux-gnueabihf
target_host=arm-linux-gnueabihf
standalone_toolchain=/usr/arm-linux-gnueabihf/
cc_compiler=gcc
cxx_compiler=g++

[env]
CONAN_CMAKE_FIND_ROOT_PATH=$standalone_toolchain/$target_host
CONAN_CMAKE_SYSROOT=$standalone_toolchain/$target_host/sysroot
PATH=[$standalone_toolchain/bin]
CHOST=$target_host
AR=$target_host-ar
AS=$target_host-as
RANLIB=$target_host-ranlib
LD=$target_host-ld
STRIP=$target_host-strip
CC=$target_host-$cc_compiler
CXX=$target_host-$cxx_compiler
CXXFLAGS=-I"$standalone_toolchain/$target_host/lib/include"
LD_LIBRARY_PATH=$standalone_toolchain/lib:$LD_LIBRARY_PATH

[settings]
# We are cross-building to Windows
os=Linux
arch=armv7
compiler=gcc

# Adjust to the gcc version of your MinGW package
compiler.version=5.4
compiler.libcxx=libstdc++11
build_type=Release
```

- Скомпилировать все зависимости, под нашу платформу
```
git clone https://github.com/conan-io/examples.git && cd examples/libraries/poco/md5
mkdir -p build && cd build
conan install .. --build=missing --profile=armv7
conan build ..
```

(win)
```
cmake .. -G "Visual Studio 16"
cmake --build . --config Release
```

(linux, mac)
```
cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release
cmake --build .
```

### Cmake

- conan info .. --graph=file.html
- conan info ..

```
[requires]
opencv/4.5.5

[generators]
cmake

[options]
opencv:shared=False
opencv:with_gtk=False
opencv:with_ffmpeg=False
opencv:with_jpeg=False
```

#### Error

Error message:
```
configure: error: in `/root/.conan/data/libjpeg/9d/_/_/build/a5fb1f047ac4f410fcc6dc60332fa67b0d6123ea':
configure: error: C preprocessor "/usr/bin/arm-linux-gnueabihf-cpp" fails sanity check
See `config.log' for more details
libjpeg/9d:
```

solution:
```
ln -s /usr/bin/arm-linux-gnueabihf-cpp-4.9 /usr/bin/arm-linux-gnueabihf-cpp
```

Error message:
```
/usr/lib32/libm.so: error adding symbols: File in wrong format
collect2: error: ld returned 1 exit status
CMakeFiles/sqlite3-bin.dir/build.make:104: recipe for target 'bin/sqlite3' failed
make[2]: *** [bin/sqlite3] Error 1
```

solution:
```
ln -s /usr/arm-linux-gnueabihf/lib  /usr/lib32
```

#### Clear all cache

```
conan remove "*" -s -b -f
```
