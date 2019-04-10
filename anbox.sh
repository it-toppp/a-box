#!/bin/bash
echo "Enter teamviewer password: "
read PASS

useradd -G sudo -d /home/test -m -s /bin/bash bot
passwd $PASS

sudo apt update
sudo apt install xubuntu-core -y
sudo add-apt-repository ppa:morphis/anbox-support -y
sudo apt update
sudo apt install xubuntu-desktop anbox-modules-dkms snap wget mc git htop lzip unzip squashfs-tools -y
sudo modprobe ashmem_linux
sudo modprobe binder_linux
sudo snap install --devmode --beta anbox
sudo apt install android-tools-adb -y

cd /home/bot
wget https://www.cdn.whatsapp.net/android/2.18.379/WhatsApp.apk
wget https://github.com/it-toppp/a-box/raw/master/AutoResponder.apk
#adb install ./WhatsApp.apk
#adb install ./AutoResponder.apk
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
wget https://raw.githubusercontent.com/it-toppp/a-box/master/wp.sh && chmod 777 ./wp.sh
chmod 777 ./teamviewer_amd64.deb
apt install ./teamviewer_amd64.deb -y
teamviewer passwd $PASS
ping 8.8.8.8 -c 10
teamviewer license accept
teamviewer info | grep ID
read -n 1 -s -r -p "your password: $PASS    Copy Teamviewer ID   and Press any key to continue"
rm /root/anbox.sh
reboot
