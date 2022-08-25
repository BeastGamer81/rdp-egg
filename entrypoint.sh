#! /bin/sh

cd /home/container || exit 1;
		

        echo "[Dark RDP Script] Please enter your Chrome RDP Auth Command:";
	read $authcmd
	echo "[Dark RDP Script] Please enter your Keyboard layout:";
	read $keyboardlayout
	echo "[Dark RDP Script] Please enter your PIN";
	read $pin
	echo "[Dark RDP Script] Please enter your PIN again";
	read $pin-confirm
	echo "[Dark RDP Script] Installing your Debian RDP";
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
	  echo "[Dark RDP Script] Your debian RDP is ready, Thank you for using this script!"
        exit 0;
        ;;
    esac
fi
