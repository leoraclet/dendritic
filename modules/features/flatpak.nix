{
  flake.nixosModules.power = { ... }: {
    services.flatpak.enable = true;
  };
}
