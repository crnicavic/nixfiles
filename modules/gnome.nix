{ config, lib, pkgs, ... }:
{
	services.xserver.desktopManager.gnome.enable = true;
	environment.gnome.excludePackages = (with pkgs; [
		gnome-photos
		gnome-tour
		gedit
	]) ++ (with pkgs; [
		cheese # webcam tool
		gnome-music
		gnome-terminal
		epiphany # web browser
		geary # email reader
		evince # document viewer
		gnome-characters
		totem # video player
		tali # poker game
		iagno # go game
		hitori # sudoku game
		atomix # puzzle game
	]);
	services.power-profiles-daemon.enable=false;
}
