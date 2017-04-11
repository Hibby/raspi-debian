#!/bin/sh
set -e

ROOTDIR="$1"

# Don't start services during installation.
echo exit 101 > $ROOTDIR/usr/sbin/policy-rc.d
chmod +x $ROOTDIR/usr/sbin/policy-rc.d

# Configure apt to pull from apt-cacher-ng
export DEBIAN_FRONTEND=noninteractive
mkdir -p $ROOTDIR/etc/apt/sources.list.d/
mkdir -p $ROOTDIR/etc/apt/apt.conf.d/
echo "Acquire::http { Proxy \"http://localhost:3142\"; };" > $ROOTDIR/etc/apt/apt.conf.d/50apt-cacher-ng
cp etc/apt/sources.list $ROOTDIR/etc/apt/sources.list
cp etc/apt/apt.conf.d/50raspi $ROOTDIR/etc/apt/apt.conf.d/50raspi
chroot $ROOTDIR apt-get update

# Install a blank RC.local
cp etc/rc.local.blank $ROOTDIR/etc/rc.local
chmod a+x $ROOTDIR/etc/rc.local
cp /etc/init.d/rc.local $ROOTDIR/etc/init.d/rc.local
chroot $ROOTDIR update-rc.d rc.local defaults

# Install helpful config files for boot & kernel
cp boot/cmdline.txt $ROOTDIR/boot/cmdline.txt
cp boot/config.txt $ROOTDIR/boot/config.txt
cp etc/fstab $ROOTDIR/etc/fstab
cp etc/modules $ROOTDIR/etc/modules

# Install kernel and requirements to set it up properly.
mkdir -p $ROOTDIR/lib/modules
chroot $ROOTDIR apt-get install -y ca-certificates curl binutils git-core kmod kpartx wget initramfs-tools
wget https://raw.github.com/Hexxeh/rpi-update/master/rpi-update -O $ROOTDIR/usr/local/sbin/rpi-update
chmod a+x $ROOTDIR/usr/local/sbin/rpi-update
SKIP_WARNING=1 SKIP_BACKUP=1 ROOT_PATH=$ROOTDIR BOOT_PATH=$ROOTDIR/boot $ROOTDIR/usr/local/sbin/rpi-update

# Install packages as requested by Tom
chroot $ROOTDIR apt-get install -y apt-utils vim whiptail netbase less net-tools isc-dhcp-client man-db
chroot $ROOTDIR apt-get install -y anacron fake-hwclock netcat-openbsd tcpdump ntp
# make it pop (with mate)
chroot $ROOTDIR apt-get install -y xorg lightdm mate-desktop-environment network-manager-gnome firefox
# debian hamradio blend // other packages
chroot $ROOTDIR apt-get install -y hamradio-antenna hamradio-datamodes \
hamradio-digitalvoice hamradio-logging hamradio-morse hamradio-nonamateur \
hamradio-packetmodes hamradio-rigcontrol hamradio-satellite hamradio-sdr \
hamradio-tools hamradio-training

# Add any custom config for new packages here

# Done.
rm $ROOTDIR/usr/sbin/policy-rc.d
rm $ROOTDIR/etc/apt/apt.conf.d/50apt-cacher-ng
