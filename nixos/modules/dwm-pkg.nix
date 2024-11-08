with import <nixpkgs> {};
with fetchgit;
let
in stdenv.mkDerivation {
	name = "dwm";
	system = "x86_64-linux";
	nativeBuildInputs = [
		pkg-config
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
		hash = "sha256-VF67Ix/ydwALHJZjh60RzGG4renSoUHSeY3OnDwSSSQ=";
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
	
	meta = with stdenv.lib; {
		description = "dwm";
		platforms = ["x86_64-linux"];
	};
}

