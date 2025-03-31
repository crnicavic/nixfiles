{ config, lib, pkgs, ... }: 
let
	# generate via openvpn --genkey --secret openvpn-laptop.key
	client-key = "/home/user/openvpn-laptop.key";
	domain = "govnoobeseno.duckdns.org";
	vpn-dev = "tun0";
	port = 1194;
in {
	imports = [ 
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
		mc
		htop
		openvpn
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

	networking.firewall.allowedTCPPorts = [ 445 139 port ];
	networking.firewall.allowedUDPPorts = [ 137 138 port ];
	networking.firewall.enable = true;
	networking.firewall.allowPing = true;
	services.duckdns = {
		enable = true;
		domains = ["govnoobeseno"];
		tokenFile = "/home/user/duckdns-token";
	};

# sudo systemctl start nat
	networking.nat = {
		enable = true;
		externalInterface = "eno1";
		internalInterfaces  = [ vpn-dev ];
	};
	networking.firewall.trustedInterfaces = [ vpn-dev ];
		services.openvpn.servers.smartphone.config = ''
		dev ${vpn-dev}
	proto udp
		ifconfig 10.8.0.1 10.8.0.2
		secret ${client-key}
	port ${toString port}

	cipher AES-256-CBC
		auth-nocache

		comp-lzo
		keepalive 10 60
		ping-timer-rem
		persist-tun
		persist-key
		'';

	environment.etc."openvpn/smartphone-client.ovpn" = {
		text = ''
			dev tun
			remote "${domain}"
			ifconfig 10.8.0.2 10.8.0.1
			port ${toString port}
		redirect-gateway def1

			cipher AES-256-CBC
			auth-nocache

			comp-lzo
			keepalive 10 60
			resolv-retry infinite
			nobind
			persist-key
			persist-tun
			secret [inline]

			'';
		mode = "600";
	};
	system.activationScripts.openvpn-addkey = ''
		f="/etc/openvpn/smartphone-client.ovpn"
		if ! grep -q '<secret>' $f; then
			echo "appending secret key"
				echo "<secret>" >> $f
				cat ${client-key} >> $f
				echo "</secret>" >> $f
				fi
				'';

	system.stateVersion = "24.05"; 
}

