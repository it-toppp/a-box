sudo apt update
sudo apt install xubuntu-desktop -y
sudo add-apt-repository ppa:morphis/anbox-support -y
sudo apt update
sudo apt install xubuntu-desktop anbox-modules-dkms snap wget mc git htop lzip unzip squashfs-tools -y
sudo modprobe ashmem_linux
sudo modprobe binder_linux
sudo snap install --devmode --beta anbox
sudo apt install android-tools-adb -y

useradd -G sudo -d /home/test -s /bin/bash test
mkdir /home/test
chown test:test -R /home/test

cd /home/test
#wget https://www.cdn.whatsapp.net/android/2.18.379/WhatsApp.apk
#wget https://github.com/it-toppp/anbox/raw/master/AutoResponder.apk
#adb install ./WhatsApp.apk
#adb install ./AutoResponder.apk

wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
chmod 777 ./teamviewer_amd64.deb
dpkg -i ./teamviewer_amd64.deb -y
teamviewer passwd 90909090
passwd test
teamviewer info
