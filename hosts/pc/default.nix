{ config, lib, pkgs, ... }: 
{
	imports = [ 
		# Include the results of the hardware scan.
		./hardware-configuration.nix

		../../packages.nix

		../../modules/tlp.nix
		../../modules/xserver.nix
		../../modules/vmware.nix
		../../modules/steam.nix
		../../modules/dwm.nix
		../../modules/gnome.nix
		../../modules/pipewire.nix
		../../modules/docker.nix
	];

	# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
		
	networking.hostName = "nixpc";
	networking.networkmanager.enable = true;

	boot.initrd.kernelModules = [ "amdgpu" ];

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;

	hardware.graphics.enable32Bit = true;	

	services.gvfs.enable = true;

	nix.settings.experimental-features = [ "nix-command" "flakes"];
	
	nixpkgs.config.allowUnfree = true;

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

