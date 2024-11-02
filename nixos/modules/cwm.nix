{pkgs, ...}: {
	environment.systemPackages = with pkgs; [
		cwm
	];	
	
	services.xserver.displayManager.session = [
		{
			manage = "desktop";
			name = "cwm";
			start = ''
				setxkbmap -option caps:escape
				xset s 600
				xss-lock lock_screen +resetsaver &
				/run/current-system/sw/bin/feh --bg-scale /home/user/.background-image 
				cwm
			'';
		}
	];
}
