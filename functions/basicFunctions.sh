#!/bin/sh

CloneOrUpdateGitRepoToPackages() {
    echo "Cloning / updating " $2
    if [ ! -d ~/packages ]
    then
        mkdir ~/packages
    fi

    if [ ! -d ~/packages/$1 ]
    then
        cd ~/packages
        git clone $2
    else
        cd ~/packages/$1
        git stash
        git pull
        git stash pop
    fi
}

SetupBackgroundsFolderForBing() {
    if [ ! -d /usr/share/backgrounds/currentBingImage ]
    then
        currentUser=$(whoami)
        sudo chown -R $currentUser:$currentUser /usr/share/backgrounds/
    fi
}
