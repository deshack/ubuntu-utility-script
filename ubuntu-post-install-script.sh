#!/bin/bash

#----------------------------#
# UBUNTU POST-INSTALL SCRIPT #
#----------------------------#

echo ''
echo '#-------------------------------------------#'
echo '#     Ubuntu 13.04 Post-Install Script      #'
echo '#-------------------------------------------#'

# SYSTEM UPGRADE
function sysupgrade {
# Update Repository Information
echo 'Updating repository information...'
echo 'Requires root privileges:'
sudo apt-get update -qq
# Dist-Upgrade
echo 'Performing system upgrade...'
sudo apt-get dist-upgrade -y
echo 'Done.'
main
}

# INSTALL FAVOURITE APPLICATIONS
function appinstall {
# Install Favourite Applications
echo 'Installing selected favourite applications...'
echo 'Requires root privileges:'
# Edit the following line to setup your Favourite Applications
# - filezilla: FTP client
# - gimp: image editor
# - inkscape: vector graphics editor
# - xchat: IRC client
# - chromium-browser: Chromium Web Browser, the open source base of Google Chrome
# - audacity: audio editor and recorder
# - meld: text files differences viewer
sudo apt-get install -y --no-install-recommends filezilla gimp inkscape xchat chromium-browser audacity meld
echo 'Done.'
main
}

# INSTALL FAVOURITE SYSTEM TOOLS
function toolinstall {
echo 'Installing system tools...'
echo 'Requires root privileges:'
# Two SSH utilities, feel free to add your favourite System Tools
sudo apt-get install -y --no-install-recommends openssh-server ssh
echo 'Done.'
main
}

# INSTALL MULTIMEDIA CODECS
function codecinstall {
# Install Ubuntu Restricted Extras Applications
echo 'Installing Ubuntu Restricted Extras...'
echo 'Requires root privileges:'
sudo apt-get install -y ubuntu-restricted-extras
echo 'Done.'
main
}

# INSTALL DEV TOOLS
function devinstall {
# Install Development Tools
echo 'Installing development tools...'
echo 'Requires root privileges:'
# - bzr: Bazaar distributed version control
# - git: version control and content tracking
# - ruby: Ruby programming language
sudo apt-get install -y bzr git ruby
echo 'Done.'
main
}

# EXTRA INSTALLATION
function thirdparty {
INPUT=0
echo ''
echo 'What would you like to do? (Enter the number of your choice)'
echo ''
while [ true ]
do
echo '1. Install Google Chrome (Unstable)?'
echo '2. Install Google Talk Plugin?'
echo '3. Install Steam?'
echo '4. Install Unity Tweak Tool?'
echo '5. Install DVD playback tools?'
echo '6. Return'
echo ''
read INPUT
# Google Chrome (Unstable)
if [ "$INPUT" -eq 1 ]; then
    echo 'Downloading Google Chrome (Unstable)...'
    # Make tmp directory
    if [ -e $HOME/tmp ]; then
        mkdir -p $HOME/tmp
    else
        continue
    fi
    cd $HOME/tmp
    # Download Debian file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget https://dl.google.com/linux/direct/google-chrome-unstable_current_i386.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget https://dl.google.com/linux/direct/google-chrome-unstable_current_amd64.deb
    fi
    # Install the package
    echo 'Installing Google Chrome...'
    sudo dpkg -i google*.deb
    sudo apt-get install -fy
    # Cleanup and finish
    rm *.deb
    cd
    echo 'Done.'
    thirdparty
# Google Talk Plugin
elif [ "$INPUT" -eq 2 ]; then
    echo 'Downloading Google Talk Plugin...'
    # Make tmp directory
    if [ -e $HOME/tmp ]; then
        mkdir -p $HOME/tmp
    else
        continue
    fi
    cd $HOME/tmp
    # Download Debian file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget https://dl.google.com/linux/direct/google-talkplugin_current_i386.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb
    fi
    # Install the package
    echo 'Installing Google Talk Plugin...'
    sudo dpkg -i google*.deb
    sudo apt-get install -fy
    # Cleanup and finish
    rm *.deb
    cd
    echo 'Done.'
    thirdparty
# Steam
elif [ "$INPUT" -eq 3 ]; then
    echo 'Downloading Steam...'
    # Make tmp directory
    if [ -e $HOME/tmp ]; then
        mkdir -p $HOME/tmp
    else
        continue
    fi
    cd $HOME/tmp
    # Download Debian file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget http://repo.steampowered.com/steam/archive/precise/steam_latest.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget http://repo.steampowered.com/steam/archive/precise/steam_latest.deb
    fi
    # Install the package
    echo 'Installing Steam...'
    sudo dpkg -i steam*.deb
    sudo apt-get install -fy
    # Cleanup and finish
    rm *.deb
    cd
    echo 'Done.'
    thirdparty
# Unity Tweak Tool
elif [ "$INPUT" -eq 4 ]; then
    # Install the package
    echo 'Installing Unity Tweak Tool...'
    sudo apt-get install -y unity-tweak-tool
    echo 'Done.'
    thirdparty
# Medibuntu
elif [ "$INPUT" -eq 5 ]; then
    echo 'Adding Medibuntu repository to sources...'
    echo 'Requires root privileges:'
    sudo -E wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list && sudo apt-get update -qq && sudo apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring && sudo apt-get update -qq
    echo 'Done.'
    echo 'Installing libdvdcss2...'
    sudo apt-get install -y libdvdcss2
    echo 'Done.'
# Return
elif [ "$INPUT" -eq 6 ]; then
    clear && main
else
# Invalid Choice
    echo 'Not an option, choose again.'
    thirdparty
fi
done
}

# CONFIG
function config {
INPUT=0
echo ''
echo 'What would you like to do? (Enter the number of your choice)'
echo ''
while [ true ]
do
echo '1. Set preferred application-specific settings?'
echo '2. Show all startup applications?'
echo '3. Return'
echo ''
read INPUT
# GSettings
# You can find these options in System Settings or Unity Tweak Tool
# and in the corresponding applications' settings
if [ "$INPUT" -eq 1 ]; then
    # Font Sizes
    echo 'Setting font preferences...'
    gsettings set org.gnome.desktop.interface text-scaling-factor '1.0'
    gsettings set org.gnome.desktop.interface document-font-name 'Sans 11'
    gsettings set org.gnome.desktop.interface font-name 'Ubuntu 11'
    gsettings set org.gnome.desktop.interface monospace-font-name 'Ubuntu Mono 13'
    gsettings set org.gnome.nautilus.desktop font 'Ubuntu 11'
    gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Ubuntu Bold 11'
    gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing 'rgba'
    gsettings set org.gnome.settings-daemon.plugins.xsettings hinting 'slight'
    # Unity Settings
    echo 'Setting Unity preferences...'
    gsettings set com.canonical.Unity.ApplicationsLens display-available-apps false
    gsettings set com.canonical.unity-greeter draw-user-backgrounds true 
    gsettings set com.canonical.indicator.power icon-policy 'present'
    gsettings set com.canonical.Unity.Lenses remote-content-search 'all'
    # Nautilus Preferences
    echo 'Setting Nautilus preferences...'
    gsettings set org.gnome.nautilus.preferences sort-directories-first true
    # Gedit Preferences
    echo 'Setting Gedit preferences...'
    gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
    gsettings set org.gnome.gedit.preferences.editor create-backup-copy false
    gsettings set org.gnome.gedit.preferences.editor auto-save true
    gsettings set org.gnome.gedit.preferences.editor insert-spaces false
    gsettings set org.gnome.gedit.preferences.editor tabs-size 8
    # Rhythmbox Preferences
    echo 'Setting Rhythmbox preferences...'
    gsettings set org.gnome.rhythmbox.rhythmdb monitor-library true
    gsettings set org.gnome.rhythmbox.sources browser-views 'artists-albums'
    # Totem Preferences
    echo 'Setting Totem preferences...'
    gsettings set org.gnome.totem active-plugins "['chapters', 'movie-properties', 'skipto', 'screensaver', 'autoload-subtitles', 'recent', 'screenshot', 'save-file', 'apple-trailers', 'media_player_keys']"
    config
# Startup Applications
elif [ "$INPUT" -eq 2 ]; then
    echo 'Changing display of startup applications.'
    echo 'Requires root privileges:'    
    cd /etc/xdg/autostart/ && sudo sed --in-place 's/NoDisplay=true/NoDisplay=false/g' *.desktop
    cd
    echo 'Done.'
    config
# Return
elif [ "$INPUT" -eq 3 ]; then
    clear && main
else
# Invalid Choice
    echo 'Not an option, choose again.'
    config
fi
done
}

# CLEANUP SYSTEM
function cleanup {
INPUT=0
echo ''
echo 'What would you like to do? (Enter the number of your choice)'
echo ''
while [ true ]
do
echo ''
echo '1. Remove unused pre-installed packages?'
echo '2. Remove old kernel(s)?'
echo '3. Remove orphaned packages?'
echo '4. Remove residual config files?'
echo '5. Clean package cache?'
echo '6. Return?'
echo ''
read INPUT
# Remove Unused Pre-installed Packages
if [ "$INPUT" -eq 1 ]; then
    echo 'Removing selected pre-installed applications...'
    echo 'Requires root privileges:'
    sudo apt-get purge
    echo 'Done.'
    cleanup
# Remove Old Kernel
elif [ "$INPUT" -eq 2 ]; then
    echo 'Removing old Kernel(s)...'
    echo 'Requires root privileges:'
    sudo dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge
    echo 'Done.'
    cleanup
# Remove Orphaned Packages
elif [ "$INPUT" -eq 3 ]; then
    echo 'Removing orphaned packages...'
    echo 'Requires root privileges:'
    sudo apt-get autoremove -y
    echo 'Done.'
    cleanup
# Remove residual config files?
elif [ "$INPUT" -eq 4 ]; then
    echo 'Removing residual config files...'
    echo 'Requires root privileges:'
    sudo dpkg --purge $(COLUMNS=200 dpkg -l | grep '^rc' | tr -s ' ' | cut -d ' ' -f 2)
    echo 'Done.'
# Clean Package Cache
elif [ "$INPUT" -eq 5 ]; then
    echo 'Cleaning package cache...'
    echo 'Requires root privileges:'
    sudo apt-get clean
    echo 'Done.'
    cleanup
# Return
elif [ "$INPUT" -eq 6 ]; then
    clear && main
else
# Invalid Choice
    echo 'Not an option, choose again.'
    cleanup
fi
done
}

# END
function end {
echo ''
read -p 'Are you sure you want to quit? (Y/n) '
if [ "$REPLY" = 'n' ]; then
    clear && main
else
    exit
fi
}

# MAIN FUNCTION
function main {
INPUT=0
echo ''
echo 'What would you like to do? (Enter the number of your choice)'
echo ''
while [ true ]
do
echo '1. Perform system update & upgrade?'
echo '2. Install favourite applications?'
echo '3. Install favourite system tools?'
echo '4. Install development tools?'
echo '5. Install Ubuntu Restricted Extras?'
echo '6. Install third-party applications?'
echo '7. Configure system?'
echo '8. Cleanup the system?'
echo '9. Quit?'
echo ''
read INPUT
# System Upgrade
if [ "$INPUT" -eq 1 ]; then
    clear && sysupgrade
# Install Favourite Applications
elif [ "$INPUT" -eq 2 ]; then
    clear && appinstall
# Install Favourite Tools
elif [ "$INPUT" -eq 3 ]; then
    clear && toolinstall
# Install Dev Tools
elif [ "$INPUT" -eq 4 ]; then
    clear && devinstall
# Install Ubuntu Restricted Extras
elif [ "$INPUT" -eq 5 ]; then
    clear && codecinstall
# Install Third-Party Applications
elif [ "$INPUT" -eq 6 ]; then
    clear && thirdparty
# Configure System
elif [ "$INPUT" -eq 7 ]; then
    clear && config
# Cleanup System
elif [ "$INPUT" -eq 8 ]; then
    clear && cleanup
# End
elif [ "$INPUT" -eq 9 ]; then
    end
else
# Invalid Choice
    echo 'Not an option, choose again.'
    main
fi
done
}

# CALL MAIN FUNCTION
main

#-----------------------------------#
# END OF UBUNTU POST-INSTALL SCRIPT #
#-----------------------------------#
