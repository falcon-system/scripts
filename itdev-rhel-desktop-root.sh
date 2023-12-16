#!/bin/bash


## HEADER
render_header() {
	clear;
	echo "========================================" &&
	echo " Setup $1 " &&
	echo "========================================"
}

render_footer() {
	echo "========================================" &&
	echo " Finishing setup $1 " &&
	echo "========================================" &&
	sleep 2 &&
	clear;
}


### INSTALL
epel_release() {


	if grep  "epel-release" installed.txt
	then

		render_header "Epel Release" &&
	    echo "Epel Release installed" &&
		render_footer "Epel Release";

	else

		render_header "Epel Release" &&

	    sudo subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms &&
		wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm &&
		sudo yum install epel-release-latest-9.noarch.rpm -y --nogpgcheck &&
		sudo dnf check-update &&
		rm epel-release-latest-9.noarch.rpm &&

		render_footer "Epel Release";
	fi

}

git_coremodule() {

	if grep  "git-core-doc" installed.txt
	then

		render_header "Git Core" &&
	    echo "Git installed" &&
		render_footer "Git Core";

	else

		render_header "Git Core" &&
	    sudo dnf install git -y &&
		fapolicyd-cli --file add /usr/share/git-core/templates/ --trust-file git &&
		fapolicyd-cli --update &&
		render_footer "Git Core";
	fi
}

google_chrome() {

	if grep  "google-chrome" installed.txt
	then
		render_header "Google Chrome" &&
	   	echo "Google chrome installed" &&
		render_footer "Google Chrome";

	else

		render_header "Google Chrome" &&
	    wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm &&
		sudo yum install google-chrome-stable_current_x86_64.rpm -y --nogpgcheck &&
		sudo dnf check-update &&
		rm google-chrome-stable_current_x86_64.rpm &&
		sudo dnf remove firefox &&
		render_footer "Google Chrome";
	fi

	
} 

gnome_tweaks() {

	if grep  "gnome-tweaks" installed.txt
	then

		render_header "Gnome Tweaks" &&
	    echo "Gnome Tweaks installed"&&
		render_footer "Gnome Tweaks";
	else

		render_header "Gnome Tweaks" &&
	    sudo dnf install gnome-tweaks -y &&
		render_footer "Gnome Tweaks";

	fi
}

evolution_mail() {

	if grep  "evolution" installed.txt
	then

		render_header "Evolution Mail" &&
	    echo "Evolution installed" &&
		render_footer "Evolution Mail";

	else

		render_header "Evolution Mail" &&
	    sudo dnf install evolution -y &&
		render_footer "Evolution Mail";

	fi
}

visual_studio() {

	if grep -w "code-1" installed.txt
	then
		render_header "Visual Studio Code" &&
	    echo "Visutal Studio Code installed" &&
		render_footer "Visual Studio Code";

	else

		render_header "Visual Studio Code" &&
	    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc &&
		sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' &&
		dnf check-update &&
		sudo dnf install code &&
		fapolicyd-cli --file add /usr/share/code/ --trust-file vscode &&
		fapolicyd-cli --update &&
		render_footer "Visual Studio Code";

	fi
}

alsa_firmware() {

	if grep  "alsa-sof-firmware" installed.txt
	then

		render_header "Alsa Firmware" &&
	    echo "Alsa Firmware installed" &&
		render_footer "Alsa Firmware";

	else

		render_header "Alsa Firmware" &&
	    sudo yum install alsa-sof-firmware -y &&
		render_footer "Alsa Firmware";

	fi
}

hugo_sitegens() {

	if [ -f "/usr/bin/hugo" ]; then

		render_header "Hugo" &&
		echo "Hugo installed" &&
		render_footer "Hugo";

	else

		render_header "Hugo" &&
		cd /tmp &&
		wget https://github.com/gohugoio/hugo/releases/download/v0.121.1/hugo_extended_0.121.1_Linux-64bit.tar.gz &&
		tar -xf hugo_extended_0.121.1_Linux-64bit.tar.gz &&
		mv hugo /usr/bin &&
		rm LICENSE README.md hugo_extended_0.121.1_Linux-64bit.tar.gz &&
		fapolicyd-cli --file add /usr/bin/hugo --trust-file hugo &&
		fapolicyd-cli --update &&
		render_footer "Hugo";
	fi
}

martext_editor() {

	render_header "Marktext" &&

	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo &&
	flatpak install flathub com.github.marktext.marktext -y &&

	render_footer "Marktext";
}

itdevio_themes() {

	if [ -d "/usr/share/themes/Orchis-Dark-Compact" ]; 
	then

		render_header "Themes" &&
		echo "themes installed" &&
		render_footer "Themes";

	else

		render_header "Themes" &&
		cd /tmp &&
		git clone https://github.com/vinceliuice/Orchis-theme.git &&
		cd Orchis-theme &&
	 	/bin/bash install.sh -c dark -s compact --tweaks compact primary macos --round 7px  --shell 40 &&
		render_footer "Themes";
	fi
}


itdevio_icons() {

	if [ -d "/usr/share/icons/WhiteSur-dark" ]; 
	then

		render_header "Icons" &&
		echo "icons installed" &&
		render_footer "Icons";

	else

		render_header "Icons" &&
		cd /tmp;
		git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git &&
		cd WhiteSur-icon-theme &&
		/bin/bash install.sh -a -b;
		render_footer "Icons";

	fi
}


cockpit_machine() {

	if grep "cockpit-machines" installed.txt
	then

		render_header "Cockpit Machines" &&
	    echo "Cockpit Machines installed" &&
		render_footer "Cockpit Machines";

	else

		render_header "Cockpit Machines" &&
	    dnf install cockpit-machines -y &&
		render_footer "Cockpit Machines";

	fi
}


golang_devbuild() {

	if [ -d "/usr/local/go" ]; 
	then

		render_header "Golang" &&
		echo "Golang installed" &&
		render_footer "Golang";

	else

		render_header "Golang" &&

		USERNOW=$( w --no-header | awk 'NR==1{print $1 }');

		cd /tmp &&
		wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz  &&
		rm -rf /usr/local/go && 
		tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz &&

		if grep "export PATH=$PATH:/usr/local/go/bin" /etc/profile
		then
			echo "Golang root path exist";
		else
			echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile &&
			echo "Golang root path register";
		fi


		if grep "export GOPATH=$HOME/.local/go" /etc/skel/.bash_profile
		then
			echo "Gopath path exist";
		else
			echo "export GOPATH=$HOME/.local/go" >>  /etc/skel/.bash_profile &&
			echo "export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin" >> /etc/skel/.bash_profile &&
			echo "Gopath register";
		fi


		if grep "export GOPATH=/home/$USERNOW/.local/go" /home/$USERNOW/.bash_profile
		then
			echo "Golang environment register at userspace";
		else
			echo "export GOPATH=/home/$USERNOW/.local/go" >> /home/$USERNOW/.bash_profile &&
			echo "export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin" >> /home/$USERNOW/.bash_profile;
		fi
		

		if [ -d "/etc/fapolicyd/trust.d/golang" ]; 
		then
			echo "Golang policy is registered";
		else
			fapolicyd-cli --file add /usr/local/go/ --trust-file golang &&
			fapolicyd-cli --update;
			echo "Golang policy register successfull";
		fi

		render_footer "Golang";
	fi
}


### CONFIG

firewalld_conf() {

	render_header "Firewalld" &&

	firewall-cmd --permanent --new-zone=manage;
	firewall-cmd --zone=manage --permanent --add-source=172.27.5.80;
	firewall-cmd --zone=manage --permanent --add-source=172.27.5.81;
	firewall-cmd --zone=manage --permanent --add-service=ssh;
	firewall-cmd --zone=manage --permanent --add-service=cockpit;
	firewall-cmd --zone=public --permanent --remove-service=ssh;
	firewall-cmd --zone=public --permanent --remove-service=dhcpv6-client;
	firewall-cmd --zone=public --permanent --remove-service=cockpit;


	render_footer "Firewalld";
}

cockpit_config() {

	render_header "Cockpit";

	systemctl enable --now cockpit.socket;

	if [ -f "/etc/cockpit/cockpit.conf" ]
	then 
		echo "configuration file exist";
	else
		echo "[WebService]" > '/etc/cockpit/cockpit.conf';
	fi

	if grep -w "LoginTitle= Fakultas Adab dan Humaniora" /etc/cockpit/cockpit.conf
	then
		echo "Cockpit login title configured";
	else
		echo "LoginTitle= Fakultas Adab dan Humaniora" >> '/etc/cockpit/cockpit.conf';
	fi

	if grep -w "LoginTo= false" /etc/cockpit/cockpit.conf
	then
		echo "Cockpit login to another host configured";
	else
		echo "LoginTo= false" >> '/etc/cockpit/cockpit.conf';
	fi
	
	
	render_footer "Cockpit";
}


insights_client() {

	render_header "Insights client" &&
	insights-client --register &&
	render_footer "Insights client";
}



grub2os_config() {

	render_header "Grub" &&

	if grep -w "GRUB_DISABLE_OS_PROBER=true" /etc/default/grub
	then
		render_header "Grub" &&
		echo "Grub disable os probed configured" &&
		render_footer "Grub";
	else
		render_header "Grub" &&
		echo "GRUB_DISABLE_OS_PROBER=true" >> /etc/default/grub &&
		grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg  &&
		render_footer "Grub";
	fi
}

poklkit_config() {

	if [ -f "/etc/polkit-1/localauthority/50-local.d/47-allow-wifi-scan.pkla" ]; 
	then

		render_header "Polkit" &&
		echo "Polkit configured" &&
		render_footer "Polkit config";

	else

		render_header "Polkit" &&
		echo -e "[Allow Wifi Scan]\nIdentity=unix-user:*\nAction=org.freedesktop.NetworkManager.wifi.scan;org.freedesktop.NetworkManager.enable-disable-wifi;org.freedesktop.NetworkManager.settings.modify.own;org.freedesktop.NetworkManager.settings.modify.system;org.freedesktop.NetworkManager.network-control\nResultAny=yes\nResultInactive=yes\nResultActive=yes" > /etc/polkit-1/localauthority/50-local.d/47-allow-wifi-scan.pkla &&
		render_footer "Polkit config";

	fi 
}


init_desktop() {
	cd /tmp &&
	dnf remove firefox cheese gnome-tour -y &&
	echo $( rpm -qa ) > installed.txt  &&
	epel_release &&
	git_coremodule &&
	git_coremodule &&
	google_chrome &&
	evolution_mail &&
	visual_studio &&
	alsa_firmware &&
	hugo_sitegens &&
	martext_editor && 
	itdevio_themes &&
	cockpit_machine &&
	golang_devbuild &&
	firewalld_conf &&
	cockpit_config &&
	grub2os_config &&
	insights_client &&
	poklkit_config;
}

init_desktop;

