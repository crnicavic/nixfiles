{ config, lib, pkgs, ... }: {
	imports = [ 
		./hardware-configuration.nix

		../../packages.nix
	
		../../modules/docker.nix
		../../modules/tlp.nix
		../../modules/xserver.nix
		../../modules/pipewire.nix
		../../modules/dwm.nix
		../../modules/steam.nix
		../../modules/gnome.nix
		../../modules/librewolf.nix
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/bc2c96d4-5cc9-48d0-88f0-c4b38e2fec09";

	# not very nix-like but works for me
	environment.variables.PATH = [ "/usr/local/bin" ];

	fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];
	
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;

	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = [ "nix-command" "flakes"];

	networking.hostName = "nix-surface";
	networking.networkmanager.enable = true;

	security.polkit.enable = true;
	
	services.gvfs.enable = true;
	services.fwupd.enable = true;
	# Enable touchpad support
	services.libinput.enable = true;
	
	system.stateVersion = "24.11"; 
	system.autoUpgrade.enable = true;

	time.timeZone = "Europe/Belgrade";

	users.users.user = {
		isNormalUser = true;
		extraGroups = [ "wheel" "audio" "video" "networkmanager"];
	};
}
