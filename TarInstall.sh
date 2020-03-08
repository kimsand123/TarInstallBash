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
    downloadlink = $1
    packageName = $2
    echo $packageName
    echo $downloadLink

    wget -O /usr/local/src/$packageName $downloadLink$packageName
    result='RPM is gut'
}
clear
access=$(stat -c "%a %n" /usr/local/src)
stringarray=($access)
permission=$(expr substr ${stringarray[0]} 2 2)

if [ $permission != '77' ]
then 
    echo You don\'t have permission to make changes to this folder your permision is ${stringarray[0]} and it should be 777.
    echo You can change the permission of the folder by using the following command 
    echo
    echo sudo chmod 777 /usr/local/src
    exit 1
fi

choice='n'
while [ $choice != 'y' ]
do 
   
    
    echo Hello enter a package name which you would like yo install

    #read packageName
    packageName='nmap-7.80-1.x86_64.rpm'
    echo Are you sure this $packageName is the right package [y/n]
    read choice
done

echo Do you want to install $packageName from:
echo 1. source code
echo 2. dpkg/rpm
read choice

echo Enter the download link to download the package.
#read downloadLink
downloadLink='https://nmap.org/dist/'


if [ $choice -eq 1 ]
then 
    sourceDownload "$packageName" "$downloadLink"
    echo $result
elif [ $choice -eq 2 ]
then
    dpkgRpmDownload "$packageName" "$downloadLink"
    
    echo $result
fi

#stat -c "%a %n" /usr/local/src