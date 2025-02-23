{ lib, stdenv, fetchgit, pkg-config, autoPatchelfHook, xorg, libxcrypt, gcc-unwrapped, gnumake }:
stdenv.mkDerivation rec {
	name = "dwm";
	system = "x86_64-linux";
	nativeBuildInputs = [
		pkg-config
		autoPatchelfHook
	];
	buildInputs = [
		gcc-unwrapped
		gnumake
		xorg.libX11 
		xorg.libXrandr
		xorg.libXinerama 
		xorg.libXft
		xorg.libXext
		libxcrypt
	];
	src = fetchgit {
		url = https://github.com/crnicavic/dwm-desktop.git;
		hash = "sha256-L4zOqYVR0zNnK2ch7l/R0qS9urq13MCPVpSlBC3jWPs=";
	};
	buildPhase = ''
		make -C ./dwm/
		make -C ./dmenu/
		make -C ./dwmblocks/
		make -C ./st/
	'';
	installPhase = ''
		mkdir -p $out/bin
		mv ./dwm/dwm $out/bin
		mv ./dmenu/dmenu_run $out/bin
		mv ./dmenu/dmenu $out/bin
		mv ./dmenu/dmenu_path $out/bin
		mv ./dmenu/stest $out/bin
		mv ./dwmblocks/dwmblocks $out/bin
		mv ./st/st $out/bin
		cp ./dwm-scripts/* $out/bin
	'';
	
	meta = {
		description = "dwm";
		platforms = lib.platforms.linux;
	};
}

