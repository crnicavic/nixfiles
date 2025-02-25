# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:


{
	imports = [ 
		./hardware-configuration.nix

		../../packages.nix
	
		../../modules/docker.nix
		../../modules/tlp.nix
		../../modules/xserver.nix
		../../modules/pipewire.nix
		../../modules/dwm.nix
		../../modules/gnome.nix
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
		
	boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/bc2c96d4-5cc9-48d0-88f0-c4b38e2fec09";

	networking.hostName = "nix-surface";
	networking.networkmanager.enable = true;
	
	programs.vim.enable = true;	
	programs.vim.defaultEditor = true;

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
	time.timeZone = "Europe/Belgrade";
	
	services.gvfs.enable = true;
	
	system.autoUpgrade.enable = true;

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

	system.stateVersion = "24.11"; 

}

