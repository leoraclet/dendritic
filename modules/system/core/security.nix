{
  flake.nixosModules.security = { pkgs, ... }: {

    security = {

      polkit.enable = true;

      apparmor = {
        enable = true;
        killUnconfinedConfinables = true;
        packages = with pkgs; [
          apparmor-utils
          apparmor-profiles
          apparmor-bin-utils
          apparmor-pam
          apparmor-parser
          apparmor-init
          apparmor-teardown
        ];
      };

      # environment.shellAliases.sudo = "doas";

      doas = {
        enable = false;
        wheelNeedsPassword = false;
      };

      sudo = {
        enable = true;
        execWheelOnly = false;
        wheelNeedsPassword = false;
        extraRules = [
          {
            users = [ "leonne" ]; # apply this rule to this user
            # groups = [ "wheel" ]; # replace the line above with this line to apply the rule to groups
            # host = "ALL"; # host portion of ALL=(ALL:ALL) (i.e. the "ALL=" part), optional
            # runAs = "ALL:ALL"; # the "(ALL:ALL)" part in ALL=(ALL:ALL), optional

            commands = [
              {
                command = "ALL";
                options = [ "NOPASSWD" ];
              }
              {
                command = "${pkgs.systemd}/bin/systemctl suspend";
                options = [ "NOPASSWD" ];
              }
              {
                command = "${pkgs.systemd}/bin/reboot";
                options = [ "NOPASSWD" ];
              }
              {
                command = "${pkgs.systemd}/bin/poweroff";
                options = [ "NOPASSWD" ];
              }
            ];
          }
        ];
      };
    };
  };
}
