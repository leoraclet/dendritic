{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.workstation = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      workstationConfiguration
    ];
  };

  flake.homeConfigurations.dell = inputs.home-manager.lib.homeManagerConfiguration {
    homeManagerModules = [ ];
  };
}
