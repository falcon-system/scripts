user_interface() {
	gsettings set org.gnome.desktop.interface gtk-theme Orchis-Dark-Compact;
	gsettings set org.gnome.desktop.interface icon-theme WhiteSur-dark;
	gsettings set org.gnome.desktop.interface text-scaling-factor 0.99;
	gsettings set org.gnome.desktop.wm.preferences button-layout "right:close,minimize,maximize"
	gsettings set org.gnome.desktop.interface clock-show-seconds true;
	gsettings set org.gnome.desktop.interface clock-show-weekday true;
	gsettings set org.gnome.desktop.calendar show-weekdate true;

	mkdir ~/.ssh
	chmod 700 ~/.ssh;
}


user_interface;