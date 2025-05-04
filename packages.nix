{ pkgs, lib, config, ...}: 
{
	# fuck home-manager	
	users.users.user.packages = with pkgs; [
		tree
		arandr
		autorandr
		r2modman
		cmus
		vscodium
		xournalpp
		xfce.xfce4-screenshooter
		libreoffice
		feh
		veracrypt
		foot
		pavucontrol
	];

	programs.vim.enable = true;	
	programs.vim.defaultEditor = true;
	programs.direnv.enable = true;
	environment.systemPackages = with pkgs; [
		vim
		mutt
		git 
		mc
		vifm
		htop
		tmux
		ntfs3g
		xss-lock
		acpi
		zip
		unzip
		xorg.xhost
		wmname
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
	programs.virt-manager.enable = true;
}
