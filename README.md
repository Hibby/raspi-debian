raspi-debian
============
Builds a [Debian](http://debian.org/) Stretch image aimed towards
hamradio

Login: `root`  
Password: `raspi`

Login: `radio`
Password: `radio`

Dependencies
------------

Currently this depends on a running Debian Stretch system/VM/maybe container.
  -  Jessie is not packaged with the signing keys for stretch, so dpkg fails.

 * `apt-cacher-ng vmdebootstrap binfmt-support qemu-user-static dosfstools`

Instructions
------------

  * `sudo sh debootstrap.sh` 
  * dd the resultant file to an SD Card.
  * File issues if it's broken for some reason.
