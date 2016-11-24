function main {
  echo -n "Installationsskript für Brew Paketet und andere, die Installation kann man -a automatisiert werden.\n"
  echo "Muss Homebrew installiert werden? (y,n) [n]"
  read brewinstall
  if [ "$brewinstall" == "y" ]||[ "$1" == "-a" ]; then
		echo "#####################################################"
		echo "########### check Homebrew, and remove ##############"
		echo "#####################################################"
		checkHomeBrew
		echo "#####################################################"
		echo "########### Homebrew installieren ###################"
		echo "#####################################################"
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  	echo "#####################################################"
  	echo "########### Brew Cask installieren ##################"
  	echo "#####################################################"
  	brew tap caskroom/cask
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
}
#------------------------------------------------------------------------------------
#--------------- Funktionen ---------------------------------------------------------
#------------------------------------------------------------------------------------

function checkHomeBrew {
	if [ -d "/usr/local/Homebrew/" ]; then
    echo "Homebrew muss vorher noch entfernt werden."
    removeHomeBrew
	fi
}
function removeHomeBrew {
  echo "Homebrew wird jetzt entfernt."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
}
function installBrewPackages {
	declare -a BrewPackages=(
    'curl'
    'git'
    'docker'
    'ffmpeg'
		'gcc'
		'mas'
		'nmap'
		'pv'
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
		'-I Cython==0.23'
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
	USE_OSX_FRAMEWORKS=0 pip install kivy #to get Kivy installed
}
function installBrewCaskPackages {
	declare -a BrewCaskPackages=(
		'alfred'
		'appcleaner'
		'atom'
		'audacity'
		'caffeine'
		'calibre'
		'coconutbattery'
		'eclipse-java'
		'evernote'
		'firefox'
		'franz'
		'fritzing'
		'garmin-communicator'
		'ghc'
		'google-chrome'
		'handbrake'
		'keka'
		'lilypond'
		'mactracker'
		'mou'
		'onepassword'
		'openoffice'
		'osxfuse'
		'perian'
		'postbox'
		'skim'
		'sonic-pi'
		'steam'
		'synology-cloud-station'
		'skype'
		'transmission'
		'transmit'
		'virtualbox'
		'vlc'
		'vuescan'
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


#################################################################
####################### calling main  ###########################
#################################################################
main
#################################################################
#################################################################
#################################################################
