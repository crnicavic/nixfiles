{ config, lib, pkgs, ... }: {
	imports = [ 
		# Include the results of the hardware scan.
		./hardware-configuration.nix
		./packages.nix
		./modules/bundle.nix
	];

	# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
		
	networking.networkmanager.enable = true;

	#programs.vim.enable = true;	
	#programs.vim.defaultEditor = true;

	boot.initrd.kernelModules = [ "amdgpu" ];

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;

	hardware.graphics.enable32Bit = true;	

	services.gvfs.enable = true;

	nix.settings.experimental-features = [ "nix-command" "flakes"];
	
	# Set your time zone.
	time.timeZone = "Europe/Belgrade";

	# Enable touchpad support (enabled default in most desktopManager).
	services.libinput.enable = true;

	 # Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.user = {
		isNormalUser = true;
		extraGroups = [ "wheel" "audio" "video" "docker" "networkmanager"]; # Enable ‘sudo’ for the user.
	};
	fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];
	
	environment.variables.PATH = [ "/usr/local/bin" ];
	
	system.stateVersion = "24.05"; 
	
	system.autoUpgrade.enable = true;
}

