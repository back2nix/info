# cross compile
# https://gitlab.kitware.com/cmake/community/wikis/FAQ#how-do-i-use-a-different-compiler
x86_64-w64-mingw32-g++

# CMakeLists.txt
set(CMAKE_C_COMPILER "/usr/bin/x86_64-w64-mingw32-gcc")
set(CMAKE_CXX_COMPILER "/usr/bin/x86_64-w64-mingw32-g++")


sudo apt install -y cmake gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf
sudo apt install -y cmake libc6-armel-cross libc6-dev-armel-cross binutils-arm-linux-gnueabi libncurses5-dev build-essential bison flex libssl-dev bc
sudo apt install -y gcc-aarch64-linux-gnu

cmake .. -DCMAKE_C_COMPILER=/usr/bin/arm-linux-gnueabihf-gcc -DCMAKE_CXX_COMPILER=/usr/bin/arm-linux-gnueabihf-g++ 


# qemu

```
sudo apt-get update
sudo apt-get install debootstrap qemu qemu-user-static
#sudo qemu-debootstrap --arch armhf bionic armhf-chroot
sudo qemu-debootstrap --arch arm64 bionic arm64-chroot
sudo chroot arm64-chroot

uname -m
```

### Видео

- https://www.youtube.com/watch?v=SoGsKI_nrYU
- https://jensd.be/1126/linux/cross-compiling-for-arm-or-aarch64-on-debian-or-ubuntu
