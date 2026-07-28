{
  flake.nixosModules.logind = { ... }: {
    services.logind = {
      enable = true;
      settings.Login = {
        HandlePowerKey = "lock";
      };
    };
  };
}
