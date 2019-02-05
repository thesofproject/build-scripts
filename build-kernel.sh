#!/bin/bash

set -e

export KERNEL_PREFIX=`pwd`/../kernel

cd ${KERNEL_PREFIX}/linux
make defconfig
./scripts/kconfig/merge_config.sh \
    .config \
    ${KERNEL_PREFIX}/kconfig/base-defconfig \
    ${KERNEL_PREFIX}/kconfig/sof-defconfig  \
    ${KERNEL_PREFIX}/kconfig/hdaudio-codecs-defconfig

make -j8
