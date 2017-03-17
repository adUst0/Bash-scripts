# fresh-ubuntu.sh
#-------------------------------------------------------
echo "Click on the same icon will minimise the window."
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window true

echo "Enable Local applciation menu."
gsettings set com.canonical.Unity integrated-menus true

echo "Always show menu."
gsettings set com.canonical.Unity always-show-menus true

echo "Stop sending search terms from Dash to hird party companies."
gsettings set com.canonical.Unity.ApplicationsLens display-available-apps false

# echo "Move Unity luncher to the bottom (Ubuntu 16.04 only)"
# gsettings set com.canonical.Unity.Launcher launcher-position Bottom

echo "Checking for updates..."
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade

echo "Installing unity-tweak-tool..."
sudo apt-get install unity-tweak-tool

echo "Installing Sublime Text 3..."
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update
sudo apt-get install sublime-text-installer

echo "Installing vim..." 
sudo apt-get install vim

echo "Installing python-pygments and creating alias ccat for syntax highlighted cat..." 
sudo apt-get install python-pygments
echo -e "\nalias ccat='pygmentize -g'" >> ~/.bash_aliases 

echo "Installing wine..." 
sudo apt-get install wine 

echo "Installing VLC Player..."
sudo apt-get install vlc 

echo "Installing GIMP..."
sudo apt-get install gimp gimp-data gimp-plugin-registry gimp-data-extras

echo "Installing Flash Player..."
sudo apt-get install flashplugin-installer 

echo "Installing ubuntu-restricted-extras..."
sudo apt-get install ubuntu-restricted-extras 

echo "Installing nVidia drivers..."
if lspci | grep -i vga | grep -i nvidia; then
	sudo apt-get purge nvidia-*
	sudo add-apt-repository ppa:graphics-drivers/ppa
	sudo apt-get update
	sudo apt-get install nvidia-378 nvidia-settings nvidia-prime prime-indicator
	nvidiaInstalled=yes
else 
	echo "No nVidia card found." >&2
fi

echo "Cleaning up..." &&
sudo apt-get -f install &&
sudo apt-get autoremove &&
sudo apt-get -y autoclean &&
sudo apt-get -y clean

if [[ $nvidiaInstalled == yes ]]; then
	echo "Rebooting..."
	sudo reboot 
fi
#-------------------------------------------------------