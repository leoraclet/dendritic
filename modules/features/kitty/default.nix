{
  self,
  inputs,
  ...
}:
{
  flake.wrappersModules.kitty =
    {
      config,
      lib,
      ...
    }:
    {
      options.shell = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
      config = {
        args = lib.mkAfter (lib.optionals (config.shell != "") [ config.shell ]);
        "kitty.conf".path = ./kitty.conf;
      };
    };

  perSystem = { pkgs, ... }: {
    packages.kitty =
      (inputs.wrappers.wrapperModules.kitty.apply {
        inherit pkgs;
        imports = [ self.wrappersModules.kitty ];
      }).wrapper;
  };
}
