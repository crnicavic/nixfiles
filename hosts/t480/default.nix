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
	];

	# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/a0214b1d-61ba-438e-adfe-fc9538787bc8";

	networking.hostName = "nix-t480";
	networking.networkmanager.enable = true;

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
	time.timeZone = "Europe/Belgrade";
	
	services.gvfs.enable = true;
	
	system.autoUpgrade.enable = true;

	nix.settings.experimental-features = [ "nix-command" "flakes"];

	# Enable touchpad support
	services.libinput.enable = true;

	services.fwupd.enable = true;

	users.users.user = {
		isNormalUser = true;
		extraGroups = [ "wheel" "audio" "video" "networkmanager"];
	};
	fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];
	security.polkit.enable = true;

	# not very nix-like but works for me
	environment.variables.PATH = [ "/usr/local/bin" ];

	system.stateVersion = "24.05"; 

	nixpkgs.config.allowUnfree = true;

}

