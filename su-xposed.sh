#!/bin/bash -v
wget https://dl-xda.xposed.info/modules/com.bigsing.changer_v23_25075d.apk
wget https://github.com/it-toppp/a-box/raw/master/XposedInstaller_3.1.5-Magisk.apk
adb install ./com.bigsing.changer_v23_25075d.apk
adb install ./XposedInstaller_3.1.5-Magisk.apk

apt install git -y
git clone https://github.com/it-toppp/a-box.git
cp -R ./a-box/system /var/snap/anbox/common/rootfs-overlay
sudo chown -R 100000:100000 /var/snap/anbox/common/rootfs-overlay
sudo chmod -R +x /var/snap/anbox/common/rootfs-overlay/system/bin
sudo chmod -R +x /var/snap/anbox/common/rootfs-overlay/system/xbin
sudo chmod -R +x /var/snap/anbox/common/rootfs-overlay/system/priv-app/XposedInstaller/XposedInstaller.apk

snap set anbox rootfs-overlay.enable=true
snap restart anbox.container-manager
