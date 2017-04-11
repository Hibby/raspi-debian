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

Very possibly Debian Stretch.

 * `apt-cacher-ng vmdebootstrap binfmt-support qemu-user-static dosfstools`

Instructions
------------

  * `sudo sh debootstrap.sh` 
  * dd the resultant file to an SD Card.
  * File issues if it's broken for some reason.
