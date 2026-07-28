{
  flake.nixosModules.ssh = { ... }: {
    services.openssh = {
      enable = false;
      settings.PasswordAuthentication = false;
    };
  };
}
