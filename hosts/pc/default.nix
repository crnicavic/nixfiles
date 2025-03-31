{ config, lib, pkgs, ... }: 
{
	imports = [ 
# Include the results of the hardware scan.
		./hardware-configuration.nix

		../../modules/docker.nix
	];

# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nixpc";
	networking.networkmanager.enable = true;

	boot.initrd.kernelModules = [ "amdgpu" ];

	hardware.graphics.enable32Bit = true;	

	services.gvfs.enable = true;
	services.openssh = {
		enable = true;
		ports = [ 22 ];
		settings = {
			PasswordAuthentication = false;
			AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
			UseDns = true;
			X11Forwarding = true;
			PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
		};
	};

	nix.settings.experimental-features = [ "nix-command" "flakes"];

# Set your time zone.
	time.timeZone = "Europe/Belgrade";

# Enable touchpad support (enabled default in most desktopManager).
	services.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.user = {
		isNormalUser = true;
		extraGroups = [ "wheel" "libvirtd" ]; # Enable ‘sudo’ for the user.
	};
	fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

	environment.variables.PATH = [ "/usr/local/bin" ];

	system.stateVersion = "24.05"; 

	system.autoUpgrade.enable = true;

	virtualisation.libvirtd = {
		enable = true;
		qemu = {
			package = pkgs.qemu_kvm;
			runAsRoot = true;
			swtpm.enable = true;
			ovmf = {
				enable = true;
				packages = [(pkgs.OVMF.override {
					secureBoot = true;
					tpmSupport = true;
				}).fd];
			};
		};
	};
	programs.vim.enable = true;	
	programs.vim.defaultEditor = true;
	programs.direnv.enable = true;
	environment.systemPackages = with pkgs; [
		ethtool
		tree
		vim
		mutt
		git 
		wireguard-tools
		mc
		htop
		tmux
		ntfs3g
		acpi
		zip
		unzip
		xorg.xhost
		man-pages
		man-pages-posix
	];

	services.samba = {
		enable = true;
		shares = {
			myshare = {
				path = "/srv/samba/myshare";  # Change this to your desired share path
					writable = true;
				browseable = true;
				"guest ok" = "yes";  # Allow guest access
			};
		};
	};

# Ensure the directory exists and has proper permissions
	systemd.tmpfiles.rules = [
		"d /srv/samba/myshare 0777 root root -"
	];

	networking.firewall.allowedTCPPorts = [ 445 139 51820 ];
	networking.firewall.allowedUDPPorts = [ 137 138 51820 ];
	networking.firewall.enable = true;
	networking.firewall.allowPing = true;
	services.duckdns = {
		enable = true;
		domains = ["govnoobeseno"];
		tokenFile = "/home/user/duckdns-token";
	};

# enable NAT
	networking.nat.enable = true;
	networking.nat.externalInterface = "eno1";
	networking.nat.internalInterfaces = [ "wg0" ];

	networking.wireguard.interfaces = {
		wg0 = {
			ips = [ "10.100.0.1/24" ];

			listenPort = 51820;

			# This allows the wireguard server to route your traffic to the 
			# internet and hence be like a VPN for this to work you have to set
			# the dnsserver IP of your router (or dnsserver of choice) in your clients
			postSetup = ''
				${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.1/24 -o eno1 -j MASQUERADE
				'';

			# This undoes the above command
			postShutdown = ''
				${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.1/24 -o eno1 -j MASQUERADE
				'';

			privateKeyFile = "/home/user/wireguard-keys/private";

			peers = [
			{ 
				publicKey = "nVSvxKKzl3JX3oXTxeK8mcwgTZOky6/F9UJx5YuRgCg=";
				allowedIPs = [ "10.100.0.2/32" ];
			}
			];
		};
	};
}

