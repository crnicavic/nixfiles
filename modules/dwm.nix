{ config, pkgs, ... }: {
	environment.systemPackages = [
		(pkgs.callPackage ../pkgs/dwm-pkg.nix {})
	];

	services.xserver.displayManager.session = [
		{ 
			manage = "desktop";
			name = "dwm";
			start = ''
				setxkbmap -option caps:escape
				xset s 600
				xss-lock lock_screen +resetsaver &
				/run/current-system/sw/bin/feh --bg-scale /home/user/.background-image 
				dwmblocks &
				dwm
			'';
		}
	];
}
