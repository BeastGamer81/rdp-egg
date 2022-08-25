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

cd /home/container || exit 1;
		

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
          apt-get install -y wget
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
        exit 0;
        ;;
    esac
fi
