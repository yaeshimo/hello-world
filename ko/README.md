# Kernel Module
- https://wiki.archlinux.org/index.php/Kernel_modules
- https://github.com/jvns/kernel-module-fun

### on arch
make linux kernel module
use vm

pwd == .../hello-world/ko

- `pacman -S linux-headers xmlto docbook-xsl kmod inetutils bc libelf`
- `make`
- `sudo insmod hello.ko`
- `dmesg | tail`
- `lsmod | grep hello`
- `sudo rmmood hello`
- `dmesg | tail`

if neaded
`make clean`
