{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.workstation = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      workConfiguration
    ];
  };

  flake.homeConfigurations.dell = inputs.home-manager.lib.homeManagerConfiguration {
    homeManagerModules = [ ];
  };
}
