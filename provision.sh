#!/bin/bash

RUBY_MAJOR=2
RUBY_MINOR=4
RUBY_PATCH=1
CHEF_VERSION=13.2.20

RUBY_VERSION="$RUBY_MAJOR.$RUBY_MINOR.$RUBY_PATCH"


apt-get -y install lxc qemu-user-static
lxc-create -n pi -t ubuntu -- --release xenial --arch armhf
rm -f /var/lib/lxc/pi/rootfs/etc/resolv.conf
echo 'nameserver 8.8.8.8' > /var/lib/lxc/pi/rootfs/etc/resolv.conf
tee /var/lib/lxc/pi/rootfs/root/build.sh <<EOF
#!/bin/bash
apt-get update
apt-get -y install git wget build-essential zlib1g-dev libssl-dev

cd /root
wget -c -t 0 https://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR.$RUBY_MINOR/ruby-$RUBY_VERSION.tar.gz
tar -xvf ruby-$RUBY_VERSION.tar.gz
cd ruby-$RUBY_VERSION
./configure --prefix=/usr --disable-install-rdoc
make -j 5 install
gem install bundler

cd /root
git clone https://github.com/chef/chef
cd chef
git checkout v$CHEF_VERSION
cd omnibus
bundle install --without development
bundle exec omnibus build chef
EOF

lxc-start -n pi
lxc-attach -n pi -- dhclient
lxc-attach -n pi -- chmod +x /root/build.sh
lxc-attach -n pi -- /root/build.sh

cp /var/lib/lxc/pi/rootfs/root/chef/omnibus/pkg/*.deb /home/ubuntu
