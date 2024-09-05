with import <nixpkgs> {};
with fetchgit;
let
in stdenv.mkDerivation {
	name = "dwm";
	system = "x86_64-linux";
	nativeBuildInputs = [
		autoPatchelfHook
		xorg.libX11 
		xorg.libXrandr
		xorg.libXinerama 
		xorg.libXft
		xorg.libXext
		libxcrypt
	];
	buildInputs = [
		gcc-unwrapped
		gnumake
	];
	src = fetchgit {
		url = https://github.com/crnicavic/dwm-desktop.git;
		hash = "sha256-GFSsrEW/uswComqg2k8+cbN3PL0S06Yc9JAOp5jIVuU=";
	};
	buildPhase = ''
		make -C ./dwm/
		make -C ./dmenu/
		make -C ./dwmblocks/
	'';
	installPhase = ''
		mkdir -p $out/bin
		mv ./dwm/dwm $out/bin
		mv ./dmenu/dmenu_run $out/bin
		mv ./dmenu/dmenu $out/bin
		mv ./dmenu/dmenu_path $out/bin
		mv ./dmenu/stest $out/bin
		mv ./dwmblocks/dwmblocks $out/bin
		cp ./dwm-scripts/* $out/bin
	'';
	
	meta = with stdenv.lib; {
		description = "dwm";
		platforms = ["x86_64-linux"];
	};
}

