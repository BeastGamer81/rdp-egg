#!/bin/bash
#
# Copyright (c) 2022 Faiz Patel
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

# Default the TZ environment variable to UTC.
TZ=${TZ:-UTC}
export TZ

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Switch to the container's working directory
cd /home/container || exit 1

# Convert all of the "{{VARIABLE}}" parts of the command into the expected shell
# variable format of "${VARIABLE}" before evaluating the string and automatically
# replacing the values.
PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

# Display the command we're running in the output, and then execute it with the env
# from the container itself.
printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0m%s\n" "$PARSED"
# shellcheck disable=SC2086
exec env ${PARSED}

#!/bin/bash
HOME="/home/container"
HOMEA="$HOME/linux/.apt"
STAR1="$HOMEA/lib:$HOMEA/usr/lib:$HOMEA/var/lib:$HOMEA/usr/lib/x86_64-linux-gnu:$HOMEA/lib/x86_64-linux-gnu:$HOMEA/lib:$HOMEA/usr/lib/sudo"
STAR2="$HOMEA/usr/include/x86_64-linux-gnu:$HOMEA/usr/include/x86_64-linux-gnu/bits:$HOMEA/usr/include/x86_64-linux-gnu/gnu"
STAR3="$HOMEA/usr/share/lintian/overrides/:$HOMEA/usr/src/glibc/debian/:$HOMEA/usr/src/glibc/debian/debhelper.in:$HOMEA/usr/lib/mono"
STAR4="$HOMEA/usr/src/glibc/debian/control.in:$HOMEA/usr/lib/x86_64-linux-gnu/libcanberra-0.30:$HOMEA/usr/lib/x86_64-linux-gnu/libgtk2.0-0"
STAR5="$HOMEA/usr/lib/x86_64-linux-gnu/gtk-2.0/modules:$HOMEA/usr/lib/x86_64-linux-gnu/gtk-2.0/2.10.0/immodules:$HOMEA/usr/lib/x86_64-linux-gnu/gtk-2.0/2.10.0/printbackends"
STAR6="$HOMEA/usr/lib/x86_64-linux-gnu/samba/:$HOMEA/usr/lib/x86_64-linux-gnu/pulseaudio:$HOMEA/usr/lib/x86_64-linux-gnu/blas:$HOMEA/usr/lib/x86_64-linux-gnu/blis-serial"
STAR7="$HOMEA/usr/lib/x86_64-linux-gnu/blis-openmp:$HOMEA/usr/lib/x86_64-linux-gnu/atlas:$HOMEA/usr/lib/x86_64-linux-gnu/tracker-miners-2.0:$HOMEA/usr/lib/x86_64-linux-gnu/tracker-2.0:$HOMEA/usr/lib/x86_64-linux-gnu/lapack:$HOMEA/usr/lib/x86_64-linux-gnu/gedit"
STARALL="$STAR1:$STAR2:$STAR3:$STAR4:$STAR5:$STAR6:$STAR7"
export LD_LIBRARY_PATH=$STARALL
export PATH="$HOMEA/bin:$HOMEA/usr/bin:$HOMEA/sbin:$HOMEA/usr/sbin:$HOMEA/etc/init.d:$PATH"
export BUILD_DIR=$HOMEA

bold=$(echo -en "\e[1m")
nc=$(echo -en "\e[0m")
lightblue=$(echo -en "\e[94m")
lightgreen=$(echo -en "\e[92m")
clear

if [[ -f "./installed","./rdp" ]]; then
    echo "Starting Debian RDP"
    ./dist/proot -S . /bin/bash --login
else
    echo "Downloading files for Debian RDP"
    curl -sSLo debian.zip https://www.mediafire.com/file/scjjn3fbhsh947o/debian.zip/file
    curl -sSLo apth https://raw.githubusercontent.com/BeastGamer81/RDP-Egg/main/apth
    curl -sSLo unzip https://raw.githubusercontent.com/BeastGamer81/RDP-Egg/main/unzip
    chmod +x apth
    echo "Installing the OS"
    ./apth unzip >/dev/null 
    linux/usr/bin/unzip debian.zip
    linux/usr/bin/unzip root.zip
    tar -xf root.tar.gz 
    chmod +x ./dist/proot
    rm -rf debian.zip
    rm -rf root.zip
    rm -rf root.tar.gz
    touch installed
    ./dist/proot -S . /bin/bash -c "mv apth /usr/bin/"
    ./dist/proot -S . /bin/bash -c "mv unzip /usr/bin/"
    ./dist/proot -S . /bin/bash -c "apt-get update"
    ./dist/proot -S . /bin/bash -c "apt-get -y upgrade"
    ./dist/proot -S . /bin/bash -c "apt-get -y install curl"
    ./dist/proot -S . /bin/bash -c "apt-get -y install wget"
    ./dist/proot -S . /bin/bash -c "apt-get -y install neofetch"
    ./dist/proot -S . /bin/bash -c "curl -o /bin/systemctl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py"
    ./dist/proot -S . /bin/bash -c "chmod +x /bin/systemctl"
    echo "Installing RDP"
        echo "[Dark RDP EGG] Please enter your Chrome RDP Auth Command:";
	read $authcmd
	echo "[Dark RDP EGG] Please enter your Keyboard layout:";
	read $keyboardlayout
	echo "[Dark RDP EGG] Please enter your PIN";
	read $pin
	echo "[Dark RDP EGG] Please enter your PIN again";
	read $pin-confirm
	echo "[Dark RDP EGG] Installing your Debian RDP";
	  apt update
          mkdir rdp 
	  cd rdp
	  wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
	  dpkg --install chrome-remote-desktop_current_amd64.deb
          apt install -y --fix-broken
	  DEBIAN_FRONTEND=noninteractive apt install -y xfce4 desktop-base
	  bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'
	  $keyboardlayout
	  apt install -y xscreensaver
	  apt install -y task-xfce-desktop
	  usermod -a -G chrome-remote-desktop $USER
	  $authcmd
	  echo "[Dark RDP EGG] Your debian RDP is ready, Thank you for using this script!"
             ./dist/proot -S . /bin/bash --login;
fi
