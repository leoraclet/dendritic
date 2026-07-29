{
  flake.nixosModules.ntp = { ... }: {
    # https://nixos.wiki/wiki/NTP#NTP_daemon
    services.ntp.enable = false;
    services.openntpd.enable = false;
    services.chrony.enable = false;
  };
}
