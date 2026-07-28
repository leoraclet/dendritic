{ inputs, self, ... }: {
  flake.wrappersModules.niri =
    {
      config,
      lib,
      ...
    }:
    {
      # "config.kdl".path = ./config.kdl;
      options.terminal = lib.mkOption {
        type = lib.types.str;
        default = "kitty";
      };
      config = {
        settings =
          let
            noctaliaExe = lib.getExe self.packages.${config.pkgs.stdenv.hostPlatform.system}.noctalia-shell;
          in
          {
            prefer-no-csd = _: { };
            input = {
              focus-follows-mouse = _: { };
              keyboard = {
                numlock = _: { };
              };

              touchpad = {
                natural-scroll = _: { };
                tap = _: { };
              };

              workspace-auto-back-and-forth = _: { };
            };

            gestures = {
              hot-corners = {
                top-left = _: { };
                top-right = _: { };
                bottom-left = _: { };
                bottom-right = _: { };
              };
            };

            overview = {
              zoom = 0.35;
            };

            cursor = {
              hide-when-typing = _: { };
              hide-after-inactive-ms = 1000;
            };

            binds = {
              "ALT+T".spawn = config.terminal;
              "ALT+Q".close-window = _: { };

              "ALT+Left".focus-column-left = _: { };
              "ALT+Right".focus-column-right = _: { };
              "ALT+Up".focus-window-up = _: { };
              "ALT+Down".focus-window-down = _: { };

              "ALT+Shift+Left".move-column-left = _: { };
              "ALT+Shift+Right".move-column-right = _: { };
              "ALT+Shift+Up".move-window-up = _: { };
              "ALT+Shift+Down".move-window-down = _: { };

              "ALT+WheelScrollLeft".focus-column-left = _: { };
              "ALT+WheelScrollRight".focus-column-right = _: { };
              "ALT+WheelScrollDown".focus-workspace-down = _: { };
              "ALT+WheelScrollUp".focus-workspace-up = _: { };
              "ALT+TouchpadScrollLeft".focus-column-left = _: { };
              "ALT+TouchpadScrollRight".focus-column-right = _: { };
              "ALT+TouchpadScrollDown".focus-workspace-down = _: { };
              "ALT+TouchpadScrollUp".focus-workspace-up = _: { };

              "ALT+1".focus-workspace = "w0";
              "ALT+2".focus-workspace = "w1";
              "ALT+3".focus-workspace = "w2";
              "ALT+4".focus-workspace = "w3";
              "ALT+5".focus-workspace = "w4";
              "ALT+6".focus-workspace = "w5";
              "ALT+7".focus-workspace = "w6";
              "ALT+8".focus-workspace = "w7";
              "ALT+9".focus-workspace = "w8";
              "ALT+0".focus-workspace = "w9";

              "ALT+Shift+1".move-column-to-workspace = "w0";
              "ALT+Shift+2".move-column-to-workspace = "w1";
              "ALT+Shift+3".move-column-to-workspace = "w2";
              "ALT+Shift+4".move-column-to-workspace = "w3";
              "ALT+Shift+5".move-column-to-workspace = "w4";
              "ALT+Shift+6".move-column-to-workspace = "w5";
              "ALT+Shift+7".move-column-to-workspace = "w6";
              "ALT+Shift+8".move-column-to-workspace = "w7";
              "ALT+Shift+9".move-column-to-workspace = "w8";
              "ALT+Shift+0".move-column-to-workspace = "w9";
            };
            spawn-at-startup = [
              noctaliaExe
            ];
          };
      };
    };

  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        imports = [ self.wrappersModules.niri ];
      };
    };
}
