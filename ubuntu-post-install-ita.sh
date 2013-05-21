#!/bin/bash

#----------------------------#
# UBUNTU SCRIPT POST-INSTALLAZIONE #
#----------------------------#

echo ''
echo '#-------------------------------------------#'
echo '#  Ubuntu 13.04 Script Post-Installazione   #'
echo '#-------------------------------------------#'

# AGGIORNAMENTO SISTEMA
function sysupgrade {
# Aggiornamento delle informazioni dei repository
echo 'Aggiornando le informazioni dei repository...'
echo 'Richiede privilegi di root:'
sudo apt-get update -qq
# Dist-Upgrade
echo 'Aggiornando il sistema...'
sudo apt-get dist-upgrade -y
echo 'Fatto.'
main
}

# INSTALLAZIONE APPLICAZIONI PREFERITE
function appinstall {
# Installa le applicazioni preferite
echo 'Installazione le applicazioni preferite selezionate...'
echo 'Richiede privilegi di root:'
# Modifica la seguente riga per impostare le tue applicazioni preferite
# - filezilla: client FTP
# - gimp: editor di immagini
# - inkscape: editor di grafica vettoriale
# - xchat: client IRC
# - chromium-browser: Chromium Browser Web, la base open source di Google Chrome
# - audacity: editor e registratore audio
# - meld: visualizzatore di differenze in file di testo
sudo apt-get install -y --no-install-recommends filezilla gimp inkscape xchat chromium-browser audacity meld
echo 'Fatto.'
main
}

# INSTALLAZIONE STRUMENTI DI SISTEMA PREFERITI
function toolinstall {
echo 'Installazione gli strumenti di sistema...'
echo 'Richiede privilegi di root:'
# Due utilità SSH, sentiti libero di aggiungere i tuoi strumenti di sistema preferiti
sudo apt-get install -y --no-install-recommends openssh-server ssh
echo 'Fatto.'
main
}

# INSTALLAZIONE CODEC MULTIMEDIALI
function codecinstall {
# Installa Ubuntu Restricted Extras Applications
echo 'Installazione Ubuntu Restricted Extras...'
echo 'Richiede privilegi di root:'
sudo apt-get install -y ubuntu-restricted-extras
echo 'Fatto.'
main
}

# INSTALLAZIONE STRUMENTI PER SVILUPPATORI
function devinstall {
# Installa strumenti per sviluppatori
echo 'Installazione strumenti per sviluppatori...'
echo 'Richiede privilegi di root:'
# - bzr: Bazaar, controllo di versione
# - git: controllo di versione e tracciamento contenuti
# - ruby: Ruby, linguaggio di programmazione
sudo apt-get install -y bzr git ruby
echo 'Fatto.'
main
}

# INSTALLAZIONE EXTRA
function thirdparty {
INPUT=0
echo ''
echo 'Cosa vuoi fare? (Inserisci il numero della tua scelta)'
echo ''
while [ true ]
do
echo '1. Installare Google Chrome (Instabile)?'
echo '2. Installare Google Talk Plugin?'
echo '3. Installare Steam?'
echo '4. Installare Unity Tweak Tool?'
echo '5. Installare strumenti per la riproduzione DVD?'
echo '6. Indietro'
echo ''
read INPUT
# Google Chrome (Instabile)
if [ "$INPUT" -eq 1 ]; then
    echo 'Scaricamento Google Chrome (Instabile)...'
    # Crea directory tmp
    if [ -e $HOME/tmp ]; then
        mkdir -p $HOME/tmp
    else
        continue
    fi
    cd $HOME/tmp
    # Scarica il file Debian che corrisponde all'architettura del sistema
    if [ $(uname -i) = 'i386' ]; then
        wget https://dl.google.com/linux/direct/google-chrome-unstable_current_i386.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget https://dl.google.com/linux/direct/google-chrome-unstable_current_amd64.deb
    fi
    # Installa il pacchetto
    echo 'Installazione Google Chrome...'
    sudo dpkg -i google*.deb
    sudo apt-get install -fy
    # Pulizia e fine
    rm *.deb
    cd
    echo 'Fatto.'
    thirdparty
# Google Talk Plugin
elif [ $INPUT -eq 2 ]; then
    echo 'Scaricamento Google Talk Plugin...'
    # Crea directory tmp
    if [ -e $HOME/tmp ]; then
        mkdir -p $HOME/tmp
    else
        continue
    fi
    cd $HOME/tmp
    # Scarica il file Debian che corrisponde all'architettura del sistema
    if [ $(uname -i) = 'i386' ]; then
        wget https://dl.google.com/linux/direct/google-talkplugin_current_i386.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb
    fi
    # Installa il pacchetto
    echo 'Installazione Google Talk Plugin...'
    sudo dpkg -i google*.deb
    sudo apt-get install -fy
    # Pulizia e fine
    rm *.deb
    cd
    echo 'Fatto.'
    thirdparty
# Steam
elif [ "$INPUT" -eq 3 ]; then
    echo 'Scaricamento Steam...'
    # Crea directory tmp
    if [ -e $HOME/tmp ]; then
        mkdir -p $HOME/tmp
    else
        continue
    fi
    cd $HOME/tmp
    # Scarica il file Debian che corrisponde all'architettura del sistema
    if [ $(uname -i) = 'i386' ]; then
        wget http://repo.steampowered.com/steam/archive/precise/steam_latest.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget http://repo.steampowered.com/steam/archive/precise/steam_latest.deb
    fi
    # Installa il pacchetto
    echo 'Installazione Steam...'
    sudo dpkg -i steam*.deb
    sudo apt-get install -fy
    # Pulizia e fine
    rm *.deb
    cd
    echo 'Fatto.'
    thirdparty
# Unity Tweak Tool
elif [ "$INPUT" -eq 4 ]; then
    # Aggiungi repository
    echo 'Aggiunta repository di Unity Tweak Tool alle sorgenti software...'
    echo 'Richiede privilegi di root:'
    sudo add-apt-repository ppa:freyja-dev/unity-tweak-tool-daily
    # Aggiorna informazioni repository
    echo 'Aggiornamento informazioni repository...'
    sudo apt-get update -qq
    # Installa il pacchetto
    echo 'Installazione Unity Tweak Tool...'
    sudo apt-get install -y unity-tweak-tool
    echo 'Fatto.'
    thirdparty
# Medibuntu
elif [ "$INPUT" -eq 5 ]; then
    echo 'Aggiunta repository di Medibuntu alle sorgenti software...'
    echo 'Richiede privilegi di root:'
    sudo -E wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list && sudo apt-get update -qq && sudo apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring && sudo apt-get update -qq
    echo 'Fatto.'
    echo 'Installazione libdvdcss2...'
    sudo apt-get install -y libdvdcss2
    echo 'Fatto.'
# Indietro
elif [ "$INPUT" -eq 6 ]; then
    clear && main
else
# Scelta non valida
    echo 'Opzione non valida, riprovare.'
    thirdparty
fi
done
}

# CONFIGURAZIONI
function config {
INPUT=0
echo ''
echo 'Cosa vuoi fare? (Inserisci il numero della tua scelta)'
echo ''
while [ true ]
do
echo '1. Applicare le impostazioni preferite alle applicazioni?'
echo '2. Mostrare tutte le applicazioni di avvio?'
echo '3. Indietro'
echo ''
read INPUT
# GSettings
# È possibile visualizzare le opzioni seguenti nelle Impostazioni di Sistema o in Unity Tweak Tool
# e nelle preferenze delle applicazioni corrispondenti
if [ "$INPUT" -eq 1 ]; then
    # Dimensioni caratteri
    echo 'Applicazione preferenze caratteri...'
    gsettings set org.gnome.desktop.interface text-scaling-factor '1.0'
    gsettings set org.gnome.desktop.interface document-font-name 'Sans 11'
    gsettings set org.gnome.desktop.interface font-name 'Ubuntu 11'
    gsettings set org.gnome.desktop.interface monospace-font-name 'Ubuntu Mono 13'
    gsettings set org.gnome.nautilus.desktop font 'Ubuntu 11'
    gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Ubuntu Bold 11'
    gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing 'rgba'
    gsettings set org.gnome.settings-daemon.plugins.xsettings hinting 'slight'
    # Impostazioni Unity
    echo 'Applicazione preferenze Unity...'
    gsettings set com.canonical.Unity.ApplicationsLens display-available-apps false
    gsettings set com.canonical.unity-greeter draw-user-backgrounds true 
    gsettings set com.canonical.indicator.power icon-policy 'present'
    gsettings set com.canonical.Unity.Lenses remote-content-search 'all'
    # Preferenze Nautilus
    echo 'Applicazione preferenze Nautilus...'
    gsettings set org.gnome.nautilus.preferences sort-directories-first true
    # Preferenze Gedit
    echo 'Applicazione preferenze Gedit...'
    gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
    gsettings set org.gnome.gedit.preferences.editor create-backup-copy false
    gsettings set org.gnome.gedit.preferences.editor auto-save true
    gsettings set org.gnome.gedit.preferences.editor insert-spaces false
    gsettings set org.gnome.gedit.preferences.editor tabs-size 8
    # Preferenze Rhythmbox
    echo 'Applicazione preferenze Rhythmbox...'
    gsettings set org.gnome.rhythmbox.rhythmdb monitor-library true
    gsettings set org.gnome.rhythmbox.sources browser-views 'artists-albums'
    # Preferenze Totem
    echo 'Applicazione preferenze Totem...'
    gsettings set org.gnome.totem active-plugins "['chapters', 'movie-properties', 'skipto', 'screensaver', 'autoload-subtitles', 'recent', 'screenshot', 'save-file', 'apple-trailers', 'media_player_keys']"
    config
# Applicazioni di avvio
elif [ "$INPUT" -eq 2 ]; then
    echo 'Modifica la visualizzazione delle applicazioni di avvio.'
    echo 'Richiede privilegi di root:'    
    cd /etc/xdg/autostart/ && sudo sed --in-place 's/NoDisplay=true/NoDisplay=false/g' *.desktop
    cd
    echo 'Fatto.'
    config
# Indietro
elif [ "$INPUT" -eq 3 ]; then
    clear && main
else
# Opzione non valida
    echo 'Opzione non valida, riprovare.'
    config
fi
done
}

# PULIZIA SISTEMA
function cleanup {
INPUT=0
echo ''
echo 'Cosa vuoi fare? (Inserisci il numero della tua scelta)'
echo ''
while [ true ]
do
echo ''
echo '1. Rimuovere pacchetti preinstallati non usati?'
echo '2. Rimuovere vecchie versioni del kernel?'
echo '3. Rimuovere pacchetti orfani?'
echo '4. Rimuovere file di configurazione obsoleti?'
echo '5. Pulire la cache dei pacchetti?'
echo '6. Indietro?'
echo ''
read INPUT
# Rimuove pacchetti preinstallati non usati
if [ "$INPUT" -eq 1 ]; then
    echo 'Rimozione delle applicazioni preinstallate selezionate...'
    echo 'Richiede privilegi di root:'
    sudo apt-get purge
    echo 'Fatto.'
    cleanup
# Rimuove vecchie versioni del kernel
elif [ "$INPUT" -eq 2 ]; then
    echo 'Rimozione delle vecchie versioni del kernel...'
    echo 'Richiede privilegi di root:'
    sudo dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge
    echo 'Fatto.'
    cleanup
# Rimuove pacchetti orfani
elif [ "$INPUT" -eq 3 ]; then
    echo 'Rimozione pacchetti orfani...'
    echo 'Richiede privilegi di root:'
    sudo apt-get autoremove -y
    echo 'Fatto.'
    cleanup
# Rimuove i file di configurazione obsoleti
elif [ "$INPUT" -eq 4 ]; then
    echo 'Rimozione dei file di configurazione obsoleti...'
    echo 'Richiede privilegi di root:'
    sudo dpkg --purge $(COLUMNS=200 dpkg -l | grep '^rc' | tr -s ' ' | cut -d ' ' -f 2)
    echo 'Fatto.'
# Pulisce la cache dei pacchetti
elif [ "$INPUT" -eq 5 ]; then
    echo 'Pulizia cache dei pacchetti...'
    echo 'Richiede privilegi di root:'
    sudo apt-get clean
    echo 'Fatto.'
    cleanup
# Indietro
elif [ "$INPUT" -eq 6 ]; then
    clear && main
else
# Opzione non valida
    echo 'Opzione non valida, riprovare.'
    cleanup
fi
done
}

# FINE
function end {
echo ''
read -p 'Vuoi uscire davvero? (S/n) '
if [ "$REPLY" = 'n' ]; then
    clear && main
else
    exit
fi
}

# FUNZIONE PRINCIPALE
function main {
INPUT=0
echo ''
echo 'Cosa vuoi fare? (Inserisci il numero della tua scelta)'
echo ''
while [ true ]
do
echo '1. Aggiornamento del sistema?'
echo '2. Installare applicazioni preferite?'
echo '3. Installare strumenti di sistema preferiti?'
echo '4. Installare strumenti per sviluppatori?'
echo '5. Installare Ubuntu Restricted Extras?'
echo '6. Installare applicazioni di terze parti?'
echo '7. Configurare il sistema?'
echo '8. Pulire del sistema?'
echo '9. Esci?'
echo ''
read INPUT
# Aggiornamento sistema
if [ "$INPUT" -eq 1 ]; then
    clear && sysupgrade
# Installa applicazioni preferite
elif [ "$INPUT" -eq 2 ]; then
    clear && appinstall
# Installa strumenti di sistema
elif [ "$INPUT" -eq 3 ]; then
    clear && toolinstall
# Installa strumenti per sviluppatori
elif [ "$INPUT" -eq 4 ]; then
    clear && devinstall
# Installa Ubuntu Restricted Extras
elif [ "$INPUT" -eq 5 ]; then
    clear && codecinstall
# Installa applicazioni di terze parti
elif [ "$INPUT" -eq 6 ]; then
    clear && thirdparty
# Configura sistema
elif [ "$INPUT" -eq 7 ]; then
    clear && config
# Pulisce sistema
elif [ "$INPUT" -eq 8 ]; then
    clear && cleanup
# Fine
elif [ "$INPUT" -eq 9 ]; then
    end
else
# Opzione non valida
    echo 'Opzione non valida, riprovare.'
    main
fi
done
}

# CHIAMA FUNZIONE PRINCIPALE
main

#------------------------------------------#
# FINE DI UBUNTU SCRIPT POST-INSTALLAZIONE #
#------------------------------------------#
