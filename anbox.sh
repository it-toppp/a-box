echo "Enter teamviewer password: "
read TIMPASS

useradd -G sudo -d /home/test -m -s /bin/bash test
passwd test

sudo apt update
sudo apt install xubuntu-core -y
sudo add-apt-repository ppa:morphis/anbox-support -y
sudo apt update
sudo apt install xubuntu-desktop anbox-modules-dkms snap wget mc git htop lzip unzip squashfs-tools -y
sudo modprobe ashmem_linux
sudo modprobe binder_linux
sudo snap install --devmode --beta anbox
sudo apt install android-tools-adb -y

cd /home/test
wget https://www.cdn.whatsapp.net/android/2.18.379/WhatsApp.apk
wget https://github.com/it-toppp/anbox/raw/master/AutoResponder.apk
#adb install ./WhatsApp.apk
#adb install ./AutoResponder.apk
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
wget https://raw.githubusercontent.com/it-toppp/a-box/master/wp.sh && chmod 777 ./wp.sh
chmod 777 ./teamviewer_amd64.deb
apt install ./teamviewer_amd64.deb -y
teamviewer passwd $TIMPASS
ping 8.8.8.8 -c 10
teamviewer license accept
teamviewer info
