#!/bin/sh

#------------------------------------------------------------------------------------
#--------------- Programmablauf unten -----------------------------------------------
#------------------------------------------------------------------------------------


#------------------------------------------------------------------------------------
#--------------- Funktionen ---------------------------------------------------------
#------------------------------------------------------------------------------------
function checkHomeBrew {
	if [ -d "/Library/Caches/Homebrew/" ]&&[ "$macos" == "neu" ]; then
		removeHomeBrew
	else
		oldRemoveHomeBrew
	fi
}

function cleanupuninstall {
	sudo chmod 0755 /usr/local
	sudo chgr wheel /usr/local
}
function removeHomeBrew {
	ruby -e "$(curl -kfsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
	cleanupuninstall
}
function oldRemoveHomeBrew {
	# wegen der unterschiedlichen Parametrisierung von curl in den verschiedenen MacOS Versionen
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
	cleanupuninstall
}

function installHomeBrew {
	/usr/bin/ruby -e "$(curl -kfsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}
function oldInstallHomeBrew {
	# wegen der unterschiedlichen Parametrisierung von curl in den verschiedenen MacOS Versionen
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

function installBrewPackages {
	declare -a BrewPackages=(
		'ddrescue'
		'ffmpeg'
		'gcc'
		'git'
		'gnupg2'
		'gnuplot'
		'imagemagick'
		'mobile-shell'
		'nmap'
		'python'
		'pv'
		'ruby'
		'vim'
		'wget'
	)
	for i in "${BrewPackages[@]}"
	do
		echo "================================================"
		echo " Installiere $i "
		echo "================================================"
		brew install $i
		wait
		echo "================================================"
		echo "$i erfolgreich installiert"
		echo "================================================"
	done
}
function installPythonPackages {
	declare -a PythonPackages=(
		'openslides'
		'selenium'
);

	for i in "${PythonPackages[@]}"
	do
		echo "================================================"
		echo " Installiere $i "
		echo "================================================"
		pip install $i
		wait
		echo "================================================"
		echo "$i erfolgreich installiert"
		echo "================================================"
	done
}
function installBrewCaskPackages {
	declare -a BrewCaskPackages=(
		'adobe-digital-editions'
		'adobe-photoshop-lightroom'
		'adobe-reader'
		'airmail-amt'
		'amazon-cloud-drive'
		'appcleaner'
		'atom'
		'audacity'
		'boinxtv'
		'caffeine'
		'calibre'
		'chromecast'
		'coconutbattery'
		'dropbox'
		'eclipse-java'
		'evernote'
		'fluid'
		'firefox'
		'fritzing'
		'garmin-communicator'
		'ghc'
		'gimp'
		'google-chrome'
		'google-drive'
		'gpgtools'
		'handbrake'
		'haskell-plattform'
		'inkscape'
		'iphone-configuration-utility'
		'istat-menus'
		'jameica'
		'jdownloader'
		'jumpcut'
		'keka'
		'lilypond'
		'luminance'
		'mactracker'
		'mou'
		'octave'
		'onepassword'
		'openoffice'
		'osxfuse'
		'pandoc'
		'perian'
		'picasa'
		'plex-home-theater'
		'postbox'
		'prizmo'
		'sage'
		'scribus'
		'sequel-pro'
		'skim'
		'sonic-pi'
		'steam'
		'sublime-text'
		'synology-cloud-station'
		'skype'
		'texmaker'
		'thunderbird'
		'transmission'
		'transmit'
		'virtualbox'
		'viscosity'
		'vlc'
		'vuescan'
		'mysqlworkbench'
		'xampp'
		'ynab'
	);

	for i in "${BrewCaskPackages[@]}"
	do
		echo "================================================"
		echo " Installiere $i "
		echo "================================================"
		brew cask install $i
		wait
		echo "================================================"
		echo "$i erfolgreich installiert"
		echo "================================================"
	done
}
function spinner()
{
    # Funktion um ein "ich tue grad was" anzuzeigen. nach http://fitnr.com/showing-a-bash-spinner.html
    local pid=$1
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

#------------------------------------------------------------------------------------
#--------------- Programmablauf unten -----------------------------------------------
#------------------------------------------------------------------------------------
echo -n "Installationsskript für Brew Paketet und andere, die Installation kann man -a automatisiert werden.\n"
echo "Muss Homebrew installiert werden? (y,n) [n]"
read brewinstall
if [ "$brewinstall" == "y" ]||[ "$1" == "-a" ]; then
	echo "altes oder neues MacOS? [alt, neu]"
	read macos
	if [ "$macos" = "alt"]; then
		echo "#####################################################"
		echo "########### check Homebrew, and remove ##############"
		echo "#####################################################"
		checkHomeBrew
		echo "#####################################################"
		echo "########### Homebrew installieren ###################"
		echo "#####################################################"
		oldInstallHomeBrew
	else
		echo "#####################################################"
		echo "########### check Homebrew, and remove ##############"
		echo "#####################################################"
		checkHomeBrew
		echo "#####################################################"
		echo "########### Homebrew installieren ###################"
		echo "#####################################################"
		installHomeBrew
	fi
	echo "#####################################################"
	echo "########### Brew Cask installieren ##################"
	echo "#####################################################"
	brew install caskroom/cask/brew-cask
fi

echo "Sollen die (standard) Homebrew Pakete installiert werden? (y,n) [n]"
read packageinstall
if [ "$packageinstall" == "y" ]||[ "$1" == "-a" ]; then
	echo "#####################################################"
	echo "########### Brew Pakete  ############################"
	echo "#####################################################"
	installBrewPackages
fi

echo "Sollen die (standard) Python Pakete installiert werden? [y,n]"
read pythonpackageinstall
if [ "$pythonpackageinstall" == "y" ]||[ "$1" == "-a" ]; then
	echo "#####################################################"
	echo "########### Python Pakete  ##########################"
	echo "#####################################################"
	installPythonPackages
fi

echo "Sollen die (standard) Brew Cask Pakete installiert werden? [y,n]"
read brewcaskpackageinstall
if [ "$brewcaskpackageinstall" == "y" ]||[ "$1" == "-a" ]; then
	echo "#####################################################"
	echo "########### Brew Cask Pakete  #######################"
	echo "#####################################################"
	installBrewCaskPackages
fi

echo "#####################################################"
echo "########### Update ++ Upgrade  ######################"
echo "#####################################################"
#wenn das update funktioniert, dann danach das upgrade mit 'command_a' && 'command_b'
brew update && brew upgrade
echo "#####################################################"
echo "########### Brew Doktor, ist alles ok?  #############"
echo "#####################################################"
brew doctor
