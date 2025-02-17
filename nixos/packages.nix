{ pkgs, lib, config, ...}: 
let
	unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
	# fuck home-manager	
	users.users.user.packages = with pkgs; [
		firefox
		tree
		arandr
		autorandr
		cmus
		vscodium
		xfce.xfce4-screenshooter
	];

	programs.vim.enable = true;	
	programs.vim.defaultEditor = true;

	environment.systemPackages = with pkgs; [
		unstable.godot_4
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
