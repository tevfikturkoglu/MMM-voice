#!/usr/bin/env bash

echo -e "\e[0m"
echo '       `/ymNMNds-'
echo '      :mMMMMMMMMMy`'
echo '     .NMMMMMMMMMMMh'
echo '     /MMMMMMMMMMMMN'
echo '     /MMMMMMMMMMMMN                       ``    `.:+oo/.         ``       ``````       `````.`'
echo '     /MMMMMMMMMMMMN           .-:+oy` +syhd-  `/hNMMMMMNs`   `osyhy     -ohmNNmh/` +syhhdmmNM:'
echo '     /MMMMMMMMMMMMN           dMMMMm /MMMMs  :dMMMMMMMMMMs   +MMMM/   -yNMMMMMMMM+.MMMMMMMMMM`'
echo '     /MMMMMMMMMMMMN           mMMMMy dMMMm``sMMMMMMNNMMMMN   dMMMm   +NMMMMMNNMd/ oMMMMmdhyys'
echo '     /MMMMMMMMMMMMN           NMMMM/:MMMM-`yMMMMNy:--dMMMM` .MMMM+  sMMMMMh:--:`  dMMMM. ```'
echo ' `-- /MMMMMMMMMMMMN `-.       MMMMM`dMMMs sMMMMN/    /MMMm  oMMMN` +MMMMN+       .MMMMNshdd+'
echo ' /MM`/MMMMMMMMMMMMN +Nm       MMMMd:MMMm`:MMMMN-     /MMM+  mMMMs `NMMMM:        oMMMMMMMMN/'
echo ' /MM`/MMMMMMMMMMMMN oMm      `MMMModMMM/ yMMMM/      dMMh` -MMMM- /MMMMs         mMMMmo/:-.`'
echo ' :MM.:MMMMMMMMMMMMm oMm      .MMMMoMMMh  mMMMM.    `sMMh`  sMMMd  +MMMM+    `.  -MMMMh/+osy'
echo ' `NMs yMMMMMMMMMMN:`mMs      :MMMNdMMM-  dMMMMh:--+dMMs`   NMMMo  -MMMMm/--+my  oMMMMMMMMMN'
echo '  :NMs./dNMMMMMNy-:dMh`      oMMMNMMMy   /MMMMMMNNMMd/    :MMMM-   oMMMMMNNMMh  mMMMMMMMMMd'
echo '   .yNNy///+++//+dNm+`       hNmdhyso.    /mMMMMMNh/`     yNdhs     :hmNNmho-` -Nmdhso+/:-.'
echo '     .ohmNNmmmNNmy/`         .```          `-/+/-`        .``         `````    `.``'
echo '        `.-NMy-``'
echo '           NMo'
echo '     ......NMy.....`'
echo '     mMMMMMMMMMMMMMo'
echo -e "\e[0m"


# installing packages
if sudo apt-get install bison libasound2-dev autoconf automake libtool python-dev swig python-pip -y ;
then
    echo -e "\e[32m[STEP 1/7] Installing Packages |  Done\e[0m"
else
	echo -e "\e[31m[STEP 1/7] Installing Packages | Failed\e[0m"
	exit;
fi


# installing sphinxbase
cd ~
if [ ! -d "$HOME/sphinxbase" ] ;
then
    if git clone https://github.com/cmusphinx/sphinxbase.git ;
    then
        cd sphinxbase
    else
        echo -e "\e[31m[STEP 2/7] Installing sphinxbase | Failed\e[0m"
        exit;
    fi
else
    cd sphinxbase
    if ! git pull ;
    then
        echo -e "\e[31m[STEP 2/7] Installing sphinxbase | Failed\e[0m"
        exit;
    fi
fi

./autogen.sh
./configure --enable-fixed
make
sudo make install
echo -e "\e[32m[STEP 2/7] Installing sphinxbase |  Done\e[0m"


# installing pocketsphinx
cd ~
if [ ! -d "$HOME/pocketsphinx" ] ;
then
    if git clone https://github.com/cmusphinx/pocketsphinx.git ;
    then
        cd pocketsphinx
    else
        echo -e "\e[31m[STEP 3/7] Installing pocketsphinx | Failed\e[0m"
        exit;
    fi
else
    cd pocketsphinx
    if ! git pull ;
    then
        echo -e "\e[31m[STEP 3/7] Installing pocketsphinx | Failed\e[0m"
        exit;
    fi
fi

./autogen.sh
./configure
make
sudo make install
echo -e "\e[32m[STEP 3/7] Installing pocketsphinx |  Done\e[0m"


# exporting paths
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib" >> ~/.bashrc
echo "export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig" >> ~/.bashrc
echo -e "\e[32m[STEP 4/7] Exporting paths |  Done\e[0m"


# installing cmuclmtk-0.7
cd ~
if [ -d "$HOME/cmuclmtk-0.7" ] ;
then
	echo -e "\e[31m[STEP 5/7] Installing cmuclmtk-0.7 | Failed\e[0m"
	exit;
fi

wget https://sourceforge.net/projects/cmusphinx/files/cmuclmtk/0.7/cmuclmtk-0.7.tar.gz
tar -xvzf cmuclmtk-0.7.tar.gz
cd cmuclmtk-0.7
./configure
make
sudo make install
cd ..
rm -f cmuclmtk-0.7.tar.gz
echo -e "\e[32m[STEP 5/7] Installing cmuclmtk-0.7 |  Done\e[0m"


# installing tensorflow
cd ~
if [ -d "$HOME/tensorflow" ] ;
then
	echo -e "\e[31m[STEP 6/7] Installing tensorflow | Failed\e[0m"
	exit;
fi

mkdir tensorflow
cd tensorflow
wget https://github.com/samjabrahams/tensorflow-on-raspberry-pi/raw/master/bin/tensorflow-0.9.0-cp27-none-linux_armv7l.whl
sudo pip install tensorflow-0.9.0-cp27-none-linux_armv7l.whl
echo -e "\e[32m[STEP 6/7] Installing tensorflow |  Done\e[0m"


# installing g2p-seq2seq
cd ~
if [ ! -d "$HOME/g2p-seq2seq" ] ;
then
    if git clone https://github.com/cmusphinx/g2p-seq2seq.git ;
    then
        cd g2p-seq2seq
    else
        echo -e "\e[31m[STEP 7/7] Installing g2p-seq2seq | Failed\e[0m"
        exit;
    fi
else
    cd g2p-seq2seq
    if ! git pull ;
    then
        echo -e "\e[31m[STEP 7/7] Installing g2p-seq2seq | Failed\e[0m"
        exit;
    fi
fi

sudo python setup.py install
echo -e "\e[32m[STEP 7/7] Installing g2p-seq2seq |  Done\e[0m"