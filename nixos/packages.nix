{ pkgs, lib, ...}: {
	# fuck home-manager	
	users.users.user.packages = with pkgs; [
			firefox
			tree
			arandr
			autorandr
			cmus
		];

	environment.systemPackages = with pkgs; [
		vim
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
