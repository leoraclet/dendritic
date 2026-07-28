{
  flake.nixosModules.clamav = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      clamav
    ];

    services.clamav = {
      daemon.enable = false;
      fangfrisch.enable = true;
      fangfrisch.interval = "daily";
      updater = {
        enable = true;
        interval = "daily"; # man systemd.time
        frequency = 12;
      };
      scanner = {
        enable = false;
        interval = "Sat *-*-* 04:00:00";
      };
    };
  };
}
