{
  lib,
  self,
  inputs,
  ...
}:
{

  perSystem =
    {
      pkgs,
      self',
      ...
    }:
    {
      # My whole desktop in one package, includes kityy terminal
      packages.desktop = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        imports = [ self.wrappersModules.niri ];
        terminal = lib.getExe self'.packages.terminal;
      };

      # My primary flake terminal
      packages.terminal =
        (inputs.wrappers.wrapperModules.kitty.apply {
          inherit pkgs;
          imports = [ self.wrappersModules.kitty ];
          shell = lib.getExe self'.packages.fish;
        }).wrapper;
    };
}
