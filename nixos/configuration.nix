{ config, lib, pkgs, ... }: {
	imports = [ 
		./hardware-configuration.nix
		./packages.nix
		./modules/bundle.nix
	];

	# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/e8cf8f5d-0cfc-45fd-b9bd-265b662bff01";

	networking.hostName = "nixos";
	networking.networkmanager.enable = true;
	
	programs.vim.enable = true;	
	programs.vim.defaultEditor = true;

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
	time.timeZone = "Europe/Belgrade";
	
	services.gvfs.enable = true;
	
	system.autoUpgrade.enable = true;
	system.autoUpgrade.allowReboot = true;

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

}

