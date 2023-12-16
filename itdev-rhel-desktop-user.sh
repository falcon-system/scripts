#!/bin/bash

layout_config() {

	gsettings set org.gnome.desktop.interface gtk-theme Orchis-Dark-Compact;
	gsettings set org.gnome.desktop.interface icon-theme WhiteSur-dark;
	gsettings set org.gnome.desktop.interface text-scaling-factor 0.99;
	gsettings set org.gnome.desktop.wm.preferences button-layout "right:minimize,maximize,close"
	gsettings set org.gnome.desktop.interface clock-show-seconds true;
	gsettings set org.gnome.desktop.interface clock-show-weekday true;
	gsettings set org.gnome.desktop.calendar show-weekdate true;
}


sshd_configs() {

	if [ -d $HOME/.ssh ] 
	then
		echo "directory exist";
	else
		mkdir ~/.ssh;
		chmod 700 ~/.ssh;
	fi
}


base_config() {
	layout_config &&
	sshd_configs;  
}


base_config;
