#!/bin/bash

set -e

export SOF_PREFIX=`pwd`/../sof
export PATH=${SOF_PREFIX}/xtensa-byt-elf/bin/:$PATH
export PATH=${SOF_PREFIX}/xtensa-hsw-elf/bin/:$PATH
export PATH=${SOF_PREFIX}/xtensa-apl-elf/bin/:$PATH
export PATH=${SOF_PREFIX}/xtensa-cnl-elf/bin/:$PATH
export PATH=${SOF_PREFIX}/xtensa-imx-elf/bin/:$PATH
export PATH=${SOF_PREFIX}/xtensa-imx8m-elf/bin/:$PATH

cd ${SOF_PREFIX}
cd crosstool-ng

 ./bootstrap
 ./configure --prefix=`pwd`
 make
 make install

cp config-byt-gcc8.1-gdb8.1 .config
./ct-ng build
cp config-hsw-gcc8.1-gdb8.1 .config
./ct-ng build
cp config-apl-gcc8.1-gdb8.1 .config
./ct-ng build
cp config-cnl-gcc8.1-gdb8.1 .config
./ct-ng build
cp config-imx-gcc9.2-gdb8.3 .config
./ct-ng build
cp config-imx8m-gcc9.2-gdb8.3 .config
./ct-ng build
cp -r builds/* ${SOF_PREFIX}

cd ${SOF_PREFIX}/newlib-xtensa
./configure --target=xtensa-byt-elf --prefix=${SOF_PREFIX}/xtensa-root
make
make install
rm etc/config.cache
./configure --target=xtensa-hsw-elf --prefix=${SOF_PREFIX}/xtensa-root
make
make install
rm etc/config.cache
./configure --target=xtensa-apl-elf --prefix=${SOF_PREFIX}/xtensa-root
make
make install
rm etc/config.cache
./configure --target=xtensa-cnl-elf --prefix=${SOF_PREFIX}/xtensa-root
make
make install
rm etc/config.cache
./configure --target=xtensa-imx-elf --prefix=${SOF_PREFIX}/xtensa-root
make
make install
rm etc/config.cache
./configure --target=xtensa-imx8m-elf --prefix=${SOF_PREFIX}/xtensa-root
make
make install

cd ${SOF_PREFIX}
cd sof
./scripts/xtensa-build-all.sh -a
