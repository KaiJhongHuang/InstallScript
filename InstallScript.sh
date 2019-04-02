#!/bin/bash

# test190402
# Program:
#         Installing some app.....
# 
# Reference:
# http://linux.vbird.org/linux_basic/0340bashshell-scripts.php
#  
# History:
# 2018/04/02 Joseph Huang  Add sublime   v1.3
# 2018/03/29 Joseph Huang  Add whiptail  v1.1
# 2018/03/29 Joseph Huang  First Release v1.0
#

# PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
# export PATH


# 0. Initialize
Initialize () {
	# echo -e "\n==================== Check whiptail installed? ==================\n"
	whiptail_installed=$(dpkg -l | grep whiptail | wc -l)
	if [ ${whiptail_installed} -ne 1 ]; then
		sudo apt-get install -y -q whiptail
	fi
}

# 1. List package
List_package () {
	whiptail --title "List of Installation" --checklist --separate-output \
	"Bugs: 1.OK/Cancel can't choose (>> use "Esc")" 20 90 14 \
	"vim"				"Text editor" OFF \
	"Sublime"			"Sublime Text 3" OFF \
	"gparted"			".." OFF \
	"cheese"			".." OFF \
	"python-pip"		".." OFF \
	"smbclient"			".." OFF \
	"v4l-utils"			".." OFF \
	"libv4l-dev"		".." OFF \
	"libopencv-dev"		".." OFF \
	"build-essential"	".." OFF \
	"python-opencv"		".." OFF \
	"gstreamer1.0"		".." OFF \
	"gstreamer1.0-tools"		".." OFF \
	"gstreamer1.0-plugins-base"	".." OFF \
	"gstreamer1.0-plugins-good"	".." OFF \
	"gstreamer1.0-plugins-bad"	".." OFF \
	"gstreamer1.0-plugins-ugly"	".." OFF \
	"other" "For Complex Installation" OFF 2>results
}
#libgstreamer1.0-0
#"python3-pip"		".." OFF 

# 2. Install package
Install_package () {
	echo -e "\n==================== updatedb / apt-get update ==================\n"
	sudo updatedb
	sudo apt-get update

	while read choice
	do
		case $choice in
			
			# Sublime install
			Sublime) echo -e "\n================== apt-get install sublime-text-installer =============\n"
			wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
			sudo apt-get install apt-transport-https
			echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
			sudo apt-get update
			sudo apt-get install sublime-text
			# Fix problem about "right click open with..."
			cp /usr/share/applications/sublime_text.desktop /home/jh/.local/share/applications/
			sudo update-desktop-database
			;;

			otherB) echo -e "You chose otherB"
			# other choice
			;;

			# For Simple Installation
			*) PACKAGE_NAME=$choice && Install_package_aptget
			;;
		esac
		
	done < results
}

# 3. Install package by apt-get
Install_package_aptget () {
	echo -e "\n================== apt-get install ${PACKAGE_NAME} ==================\n" && \
	sudo apt-get install ${PACKAGE_NAME} -y
}

# ==================== Main ==================== 

echo -e "\n=========================== Installer ============================\n"

# 0. Initialize
Initialize

# 1. List package
List_package

# 2. Install package
Install_package

echo -e "\n=========================== Finished ============================\n"

#sudo add-apt- repository ppa:webupd8team/sublime-text- 3
#sudo apt-get update
#sudo apt-get install sublime-text- installer


#
