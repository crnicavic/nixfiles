{ config, pkgs, ... }: {
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
# If you want to use JACK applications, uncomment this
#jack.enable = true;
	};

	services.pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
		"monitor.bluez.properties" = {
			"bluez5.enable-sbc-xq" = true;
			"bluez5.enable-msbc" = true;
			"bluez5.enable-hw-volume" = true;
			"bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" "a2dp_source" ];
		};
	};
	services.pipewire.wireplumber.extraConfig."11-bluetooth-policy" = {
		"wireplumber.settings" = {
		"bluetooth.autoswitch-to-headset-profile" = false;
		};
	};

	services.blueman.enable = true;

	systemd.user.services.mpris-proxy = {
	    description = "Mpris proxy";
	    after = [ "network.target" "sound.target" ];
	    wantedBy = [ "default.target" ];
	    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
	};
}
