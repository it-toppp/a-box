#!/bin/bash -v
apt install git -y
wget https://dl-xda.xposed.info/modules/com.bigsing.changer_v23_25075d.apk
snap set anbox rootfs-overlay.enable=true
$ snap restart anbox.container-manager
sudo chown -R 100000:100000 /var/snap/anbox/common/rootfs-overlay
git clone
https://github.com/it-toppp/a-box.git
cp ./a-box/system/ /var/snap/anbox/common/rootfs-overlay
sudo chown -R 100000:100000 /var/snap/anbox/common/rootfs-overlay
sudo chmod -R +x /var/snap/anbox/common/rootfs-overlay/system/bin
sudo chmod -R +x /var/snap/anbox/common/rootfs-overlay/system/xbin
