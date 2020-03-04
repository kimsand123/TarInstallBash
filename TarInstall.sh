#!/bin/bash
#1. Ask for the package to be downloaded
#2. Then ask if it want to install from source code or with dpkg/rpm
#3. It then asks for the link to download the packages
#4. It checks/changes for the permission of the folder /usr/local/src such that everybody can
#      download and use packages downloaded there
#5. It then downloads the package in /usr/local/src
#6. It should then install the package depending on the choice of package downloaded.
#7. Report if the installation was successful
#8. If not then what was the reason (maybe there were some dependencies that were missing-
#      prompt to download and install those packages before downloaded the initial package that was
#      to be installed)
#9. find the package in apt-cache and prompt to install them and then reinstall the initial package to
#      be installed
#10. make it possible to run the script without sudo. Hint Look into sudoers file use visudo
sourceDownload() {
    result='You can download this'
}

dpkgRpmDownload() {
    result='RPM is gut'
}

choice='n'
while [ $choice != 'y' ]
do 
    clear
    echo Hello enter a package name which you would like yo install

    read packageName

    echo Are you sure this $packageName is the right package [y/n]
    read choice
done

echo Do you want to install $packageName from:
echo 1. source code
echo 2. dpkg/rpm
read choice

echo Enter the download link to download the package.
read downloadLink

if [ $choice -eq 1 ]
then 
    sourceDownload "$packageName" "$downloadLink"
    echo $result
elif [ $choice -eq 2 ]
then
    dpkgRpmDownload "$packageName" "$downloadLink"
    echo $result
fi

