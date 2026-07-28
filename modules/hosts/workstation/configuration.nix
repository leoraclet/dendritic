{ self, ... }: {

  flake.nixosModules.workstationConfiguration = { ... }: {
    # import any other modules from here
    imports = [
      self.nixosModules.desktop
    ];

    # ...
  };

}
