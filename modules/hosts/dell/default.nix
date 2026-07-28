{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.dell = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      dellConfiguration
    ];
  };

  flake.homeConfigurations.dell = inputs.home-manager.lib.homeManagerConfiguration {
    homeManagerModules = [ ];
  };
}
