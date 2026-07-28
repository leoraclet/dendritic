{
  flake.nixosModules.scanner = { pkgs, ... }: {
    services.udev.packages = [ pkgs.sane-airscan ];
    hardware.sane = {
      enable = true;
      extraBackends = [ pkgs.sane-airscan ];
    };
  };
}
