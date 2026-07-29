{
  flake.nixosModules.secret-service = { pkgs, ... }: {
    # https://wiki.nixos.org/wiki/Secret_Service
    services.passSecretService.enable = true;
    services.gnome.gnome-keyring.enable = false;
  };
}
