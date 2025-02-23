{pkgs, config, inputs, pkgs_2405, lib, ...} : {
#	nixpkgs.config.allowUnfreePredicate = pkg:
#		builtins.elem (lib.getName pkg) [
#			"vmware-workstation"
#		];

	virtualisation.vmware.host.enable = true;
}
