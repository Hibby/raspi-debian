#!/bin/sh

vmdebootstrap \
    --arch armhf \
    --distribution testing \
	--mirror http://localhost:3142/httpredir.debian.org/debian \
    --image `date +debian-testing-%Y%m%d.img` \
    --size 5000M \
    --bootsize 64M \
    --boottype vfat \
    --root-password raspi \
	--user radio/radio \
	--sudo \
    --verbose \
    --no-kernel \
    --no-extlinux \
    --hostname raspi-debian \
    --foreign /usr/bin/qemu-arm-static \
    --customize `pwd`/customize.sh \
	--log raspi-debian.log \
