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

# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/e8cf8f5d-0cfc-45fd-b9bd-265b662bff01";

	networking.hostName = "nix-t14";
	networking.networkmanager.enable = true;
#networking.firewall.enable = true;
#	networking.firewall.allowPing = true;
#	networking.firewall.allowedTCPPorts = [ 445 139 51820 ];
#	networking.firewall.allowedUDPPorts = [ 137 138 51820 ];
	
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
	time.timeZone = "Europe/Belgrade";

	nix.settings.experimental-features = [ "nix-command" "flakes"];
	system.autoUpgrade.enable = true;

# Enable touchpad support
	services.libinput.enable = true;

	services.gvfs.enable = true;
	nixpkgs.config.allowUnfree = true;
	services.fwupd.enable = true;

	services.hardware.bolt.enable = true;

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

