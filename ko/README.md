# Kernel Module
make linux kernel module


## on arch
use vm

work directory
- pwd == .../hello-world/ko

arhclinux headers
- `pacman -S linux-headers`
- `/usr/lib/modules/$(uname -r)/build/include/`

for kernel build
- `pacman -S xmlto docbook-xsl kmod inetutils bc libelf`


## make module to test
```sh
make
sudo insmod hello.ko
dmesg | tail
lsmod | grep hello
sudo rmmood hello
dmesg | tail
```

if neaded
- `make clean`


## references
- https://wiki.archlinux.org/index.php/Kernel_modules
- https://github.com/jvns/kernel-module-fun
- http://qiita.com/satoru_takeuchi/items/83c8e2f38176d2724f48
- http://hb.matsumoto-r.jp/entry/2016/05/23/152438

