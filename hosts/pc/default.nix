{ config, lib, pkgs, ... }: 
{
	imports = [ 
	# Include the results of the hardware scan.
		./hardware-configuration.nix

		../../modules/docker.nix
	];

	# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.firewall.enable = true;
	networking.hostName = "nixpc";
	networking.networkmanager.enable = true;

	boot.initrd.kernelModules = [ "amdgpu" ];

	hardware.graphics.enable32Bit = true;	

	services.gvfs.enable = true;
	services.openssh = {
		enable = true;
		ports = [ 22 ];
		settings = {
			PasswordAuthentication = true;
			AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
			UseDns = true;
			X11Forwarding = true;
			PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
		};
	};

	nix.settings.experimental-features = [ "nix-command" "flakes"];

	# Set your time zone.
	time.timeZone = "Europe/Belgrade";

	# Enable touchpad support (enabled default in most desktopManager).
	services.libinput.enable = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.user = {
		isNormalUser = true;
		extraGroups = [ "wheel" ] # Enable ‘sudo’ for the user.
	};
	fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

	environment.variables.PATH = [ "/usr/local/bin" ];

	system.stateVersion = "24.05"; 

	system.autoUpgrade.enable = true;
	
	programs.vim.enable = true;	
	programs.vim.defaultEditor = true;
	programs.direnv.enable = true;
	environment.systemPackages = with pkgs; [
		tree
		vim
		mutt
		git 
		mc
		htop
		tmux
		ntfs3g
		acpi
		zip
		unzip
		xorg.xhost
		man-pages
		man-pages-posix
	];
}

