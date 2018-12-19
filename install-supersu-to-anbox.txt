#!/bin/bash -v
#some code edited from root@geeks-r-us.de

#get zip file and set workdir
mkdir -p ~/temp
cd ~/temp
wget http://www.devfiles.co/download/74iPUjZd/SuperSU-v2.82-201705271822.zip
cd ..
mkdir -p "$(pwd)/anbox-work" 
unzip ~/temp/SuperSU-v2.82-201705271822.zip -d "$(pwd)/anbox-work/su" 
WORKDIR="$(pwd)/anbox-work"  
cd "$WORKDIR" 

#get image from anbox
cp /snap/anbox/current/android.img .
sudo unsquashfs android.img

sudo mkdir -p ./squashfs-root/system/app/SuperSU
sudo mkdir -p ./squashfs-root/system/bin/.ext/

sudo cp ./su/common/Superuser.apk ./squashfs-root/system/app/SuperSU/SuperSU.apk
sudo cp ./su/common/install-recovery.sh ./squashfs-root/system/etc/install-recovery.sh
sudo cp ./su/common/install-recovery.sh ./squashfs-root/system/bin/install-recovery.sh  
sudo cp ./su/x64/su ./squashfs-root/system/xbin/su
sudo cp ./su/x64/su ./squashfs-root/system/bin/.ext/.su
sudo cp ./su/x64/su ./squashfs-root/system/xbin/daemonsu
sudo cp ./su/x64/supolicy ./squashfs-root/system/xbin/supolicy
sudo cp ./su/x64/libsupol.so ./squashfs-root/system/lib64/libsupol.so
sudo cp ./squashfs-root/system/bin/app_process64 ./squashfs-root/system/bin/app_process_init
sudo cp ./squashfs-root/system/bin/app_process64 ./squashfs-root/system/bin/app_process64_original
sudo cp ./squashfs-root/system/xbin/daemonsu ./squashfs-root/system/bin/app_process
sudo cp ./squashfs-root/system/xbin/daemonsu ./squashfs-root/system/bin/app_process64

sudo chmod +x ./squashfs-root/system/app/SuperSU/SuperSU.apk
sudo chmod +x ./squashfs-root/system/etc/install-recovery.sh
sudo chmod +x ./squashfs-root/system/bin/install-recovery.sh
sudo chmod +x ./squashfs-root/system/xbin/su
sudo chmod +x ./squashfs-root/system/bin/.ext/.su
sudo chmod +x ./squashfs-root/system/xbin/daemonsu
sudo chmod +x ./squashfs-root/system/xbin/supolicy
sudo chmod +x ./squashfs-root/system/lib64/libsupol.so
sudo chmod +x ./squashfs-root/system/bin/app_process_init
sudo chmod +x ./squashfs-root/system/bin/app_process64_original
sudo chmod +x ./squashfs-root/system/bin/app_process
sudo chmod +x ./squashfs-root/system/bin/app_process64

#squash img
sudo rm android.img
sudo mksquashfs squashfs-root android.img -b 131072 -comp xz -Xbcj ia64

# update anbox snap images
cd /var/lib/snapd/snaps

until sudo systemctl stop snap.anbox.container-manager.service 
do 
	sleep 10 
done 

for filename in anbox_*.snap 
do 
    NUMBER=${filename//[^0-9]/} 
		if [ "$NUMBER" ]; then 
    	echo "changing anbox snap $NUMBER" 
    	until sudo systemctl stop snap-anbox-$NUMBER.mount 
		do 
			sleep 10 
		done 
    	sudo unsquashfs $filename 
    	sudo mv ./squashfs-root/android.img ./android.img-$NUMBER 
    	sudo cp "$WORKDIR/android.img" ./squashfs-root 
    	sudo rm $filename 
    	sudo mksquashfs squashfs-root $filename -b 131072 -comp xz -Xbcj ia64
    	sudo rm -rf ./squashfs-root 
    	sudo systemctl start snap-anbox-$NUMBER.mount 
		else 
			echo "Could not find number for: $filename" 
		fi 
done 
sudo systemctl start snap.anbox.container-manager.service

#clean up
rm -rf ~/temp
sudo rm -rf "$WORKDIR"
