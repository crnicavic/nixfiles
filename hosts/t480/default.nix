{ config, lib, pkgs, ... }: {
	imports = [ 
		./hardware-configuration.nix

		../../packages.nix

		../../modules/docker.nix
		../../modules/dwm.nix
		../../modules/gnome.nix
		../../modules/vmware.nix
		../../modules/xserver.nix
		../../modules/tlp.nix
		../../modules/pipewire.nix
		../../modules/librewolf.nix
	];

	# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/a0214b1d-61ba-438e-adfe-fc9538787bc8";
	
	# not very nix-like but works for me
	environment.variables.PATH = [ "/usr/local/bin" ];

	fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
	
	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = [ "nix-command" "flakes"];

	networking.hostName = "nix-t480";
	networking.networkmanager.enable = true;

	security.polkit.enable = true;

	# Enable touchpad support
	services.libinput.enable = true;
	services.hardware.bolt.enable = true;
	services.gvfs.enable = true;
	services.fwupd.enable = true;
	
	system.autoUpgrade.enable = true;
	system.stateVersion = "24.05"; 
	
	time.timeZone = "Europe/Belgrade";

	users.users.user = {
		isNormalUser = true;
		extraGroups = [ "wheel" "audio" "video" "networkmanager"];
	};
}

