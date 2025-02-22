{pkgs, config, inputs, pkgs_2405, lib, ...} : {
	nixpkgs.config.allowUnfreePredicate = pkg:
		builtins.elem (lib.getName pkg) [
			"vmware-workstation"
		];
	_module.args.pkgs_2405 = import inputs.nixpkgs_2405 {
		inherit (pkgs.stdenv.hostPlatform) system;
		inherit (config.nixpkgs) config;
	};
	
	virtualisation.host.vmware.enable = true;
	virtualisation.host.vmware.package = pkgs_2405.vmware-workstation;
}
