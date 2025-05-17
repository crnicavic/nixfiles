{ config, lib, pkgs, ... }: 
{
	imports = [ 
		# Include the results of the hardware scan.
		./hardware-configuration.nix

		../../packages.nix

		../../modules/tlp.nix
		../../modules/xserver.nix
		../../modules/librewolf.nix
		../../modules/steam.nix
		../../modules/dwm.nix
		../../modules/gnome.nix
		../../modules/pipewire.nix
		../../modules/docker.nix
	];
	boot.initrd.kernelModules = [ "amdgpu" ];
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.systemd-boot.enable = true;

	environment.variables.PATH = [ "/usr/local/bin" ];

	fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
	hardware.graphics.enable32Bit = true;	

	networking.hostName = "nixpc";
	networking.networkmanager.enable = true;

	nix.settings.experimental-features = [ "nix-command" "flakes"];
	nixpkgs.config.allowUnfree = true;

	services.gvfs.enable = true;
	services.libinput.enable = true;

	system.autoUpgrade.enable = true;
	system.stateVersion = "24.05"; 

	time.timeZone = "Europe/Belgrade";

	users.users.user = {
		isNormalUser = true;
		extraGroups = [ "wheel" "audio" "video" "networkmanager"]; # Enable ‘sudo’ for the user.
	};
}

