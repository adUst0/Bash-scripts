# fresh-ubuntu.sh
#-------------------------------------------------------
function echoRed() {
	echo -e "\e[91m$1\e[0m"
}

echoRed "Click on the same icon will minimise the window."
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window true

echoRed "Enable Local applciation menu."
gsettings set com.canonical.Unity integrated-menus true

echoRed "Always show menu."
gsettings set com.canonical.Unity always-show-menus true

echoRed "Stop sending search terms from Dash to hird party companies."
gsettings set com.canonical.Unity.ApplicationsLens display-available-apps false

# echoRed "Move Unity luncher to the bottom (Ubuntu 16.04 only)"
# gsettings set com.canonical.Unity.Launcher launcher-position Bottom

# three-finger tap = mouse3
echo -e "[Desktop Entry]\nType=Application\nExec=/bin/bash -c \"synclient TapButton3=2\"\nHidden=false\nNoDisplay=false\nX-GNOME-Autostart-enabled=true\nName[en_US]=touchpad.desktop\nName=TouchpadMouse3\nComment[en_US]=\nComment=" > ~/.config/autostart/touchpad.desktop

echoRed "Checking for updates..."
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade

echoRed "Installing unity-tweak-tool..."
sudo apt-get -y install unity-tweak-tool

echoRed "Installing Sublime Text 3..."
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get -y update
sudo apt-get -y install sublime-text-installer

echoRed "Installing vim..." 
sudo apt-get -y install vim

echoRed "Installing python-pygments and creating alias ccat for syntax highlighted cat..." 
sudo apt-get -y install python-pygments
echo -e "\nalias ccat='pygmentize -g'" >> ~/.bash_aliases

echoRed "Installing VLC Player..."
sudo apt-get -y install vlc 

echoRed "Installing GIMP..."
sudo apt-get -y install gimp gimp-data gimp-plugin-registry gimp-data-extras

echoRed "Installing Flash Player..."
sudo apt-get -y install flashplugin-installer 

echoRed "Installing ubuntu-restricted-extras..."
sudo apt-get -y install ubuntu-restricted-extras 

echoRed "Installing wine..." 
sudo apt-get install wine 

echoRed "Installing nVidia drivers..."
if lspci | grep -i nvidia; then
	sudo add-apt-repository ppa:graphics-drivers/ppa
	sudo apt-get -y update
	sudo apt-get -y purge nvidia-*
	sudo apt-get -y install nvidia-381 nvidia-settings nvidia-prime prime-indicator
	nvidiaInstalled=yes
else 
	echo "No nVidia card found." >&2
fi

echoRed "Cleaning up..." &&
sudo apt-get -f install &&
sudo apt-get autoremove &&
sudo apt-get -y autoclean &&
sudo apt-get -y clean

if [[ $nvidiaInstalled == yes ]]; then
	echoRed "Rebooting..."
	sudo reboot 
fi
#-------------------------------------------------------