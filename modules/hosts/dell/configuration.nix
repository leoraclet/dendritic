{ self, ... }: {

  flake.nixosModules.dellConfiguration = { ... }: {
    # import any other modules from here
    imports = [
      self.nixosModules.desktop
    ];

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    # ...
  };

}
