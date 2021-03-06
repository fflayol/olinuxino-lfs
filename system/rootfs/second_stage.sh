
GREEN="\\033[1;32m" 
YELLOW="\\033[1;33m"
RED="\\033[1;31m" 
NORMAL="\\033[0;39m"

distro=wheezy
export LANG=C
/debootstrap/debootstrap --second-stage

cat <<EOT > /etc/apt/sources.list
deb http://ftp.uk.debian.org/debian $distro main contrib non-free
deb-src http://ftp.uk.debian.org/debian $distro main contrib non-free
deb http://ftp.uk.debian.org/debian $distro-updates main contrib non-free
deb-src http://ftp.uk.debian.org/debian $distro-updates main contrib non-free
deb http://security.debian.org/debian-security $distro/updates main contrib non-free
deb-src http://security.debian.org/debian-security $distro/updates main contrib non-free
EOT
apt-get update 
#sudo apt-get install --reinstall libc6=2.15-0ubuntu10.2 libc6-dev=2.15-0ubuntu10.2
apt-get install openssh-client  locales dialog -y
#dpkg-reconfigure locales
apt-get upgrade -y

apt-get install -f git -y
#apt-get install -f xutils-dev
apt-get install -f openssh-server ntpdate -y 
echo <<EOT >> /etc/network/interfaces 
allow-hotplug eth0
iface eth0 inet static
	address 192.168.1.254
	netmask 255.255.255.248
	gateway 192.168.1.1	
EOT


git clone https://github.com/linux-sunxi/sunxi-mali.git
cd sunxi-mali
git submodule init
git submodule update
make config
exit