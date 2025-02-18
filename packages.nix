{ pkgs, lib, config, ...}:
let
     pkgs_old = import (builtins.fetchGit {
         # Descriptive name to make the store path easier to identify
         name = "my-old-revision";
         url = "https://github.com/NixOS/nixpkgs/";
         ref = "refs/heads/nixos-24.05";
         rev = "6eb01a67e1fc558644daed33eaeb937145e17696";
     }) { inherit (pkgs) system; };

     myPkg = pkgs.vmware-workstation;
in
{ 
	nixpkgs.config.allowUnfree = true;

	users.users.user.packages = with pkgs; [
		firefox
		tree
		arandr
		autorandr
		cmus
		vscodium
		xfce.xfce4-screenshooter
		godot_4
		heroic
		r2modman
		lutris
		foot
	];
	environment.systemPackages = with pkgs; [
		input-leap
		pavucontrol
		polybar	
		vim
		mutt
		git 
		mc
		htop
		tmux
		ntfs3g
		xss-lock
		acpi
		zip
		unzip
		xorg.xhost
		wmname
		libreoffice
		feh
		pcmanfm
		man-pages
		cryptsetup
		man-pages-posix
	];
	
	fonts.packages = with pkgs; [
		hack-font
	];

	documentation.enable = true;
	documentation.man.enable = true;
	documentation.dev.enable = true;

	# backlight control
	programs.light.enable = true;
	programs.nix-ld.enable = true;
	programs.slock.enable = true;
}
