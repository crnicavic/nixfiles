{ config, lib, pkgs, ... }: {
	imports = [
		./hardware-configuration.nix

		../../packages.nix

		../../modules/docker.nix
		../../modules/dwm.nix
		../../modules/gnome.nix
		../../modules/pipewire.nix
		../../modules/tlp.nix
		../../modules/vmware.nix
		../../modules/xserver.nix
		../../modules/librewolf.nix
	];
	boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/e8cf8f5d-0cfc-45fd-b9bd-265b662bff01";
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.systemd-boot.enable = true;

	environment.variables.PATH = [ "/usr/local/bin" ];

	fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;

	networking.hostName = "nix-t14";
	networking.networkmanager.enable = true;

	nix.settings.experimental-features = [ "nix-command" "flakes"];
	nixpkgs.config.allowUnfree = true;

	security.polkit.enable = true;

	services.fwupd.enable = true;
	services.gvfs.enable = true;
	services.hardware.bolt.enable = true;
	services.libinput.enable = true;

	system.autoUpgrade.enable = true;
	system.stateVersion = "24.05"; 

	time.timeZone = "Europe/Belgrade";

	users.users.user = {
		isNormalUser = true;
		extraGroups = [ "wheel" "audio" "video" "networkmanager"];
	};
}
