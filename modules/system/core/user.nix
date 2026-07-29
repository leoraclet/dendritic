{
  flake.nixosModules.user = { pkgs, ... }: {
    users = {
      defaultUserShell = pkgs.fish;
      # Allows to change the initial password to a more robust one after firt login.
      mutableUsers = true;
      groups = { };

      users = {
        root = {
          isSystemUser = true;
          initialHashedPassword = "$y$j9T$pcb50pBBy6OSBdnB95Z500$97.KkRDmnSHRKIlFLCxwHgfMZ4DRxS5gwU4/z/op0X0";
        };
        leonne = {
          isNormalUser = true;
          description = "leonne";
          createHome = true;
          # To avoid being locked out after first install of the system
          # Because by default a new user don't have a password if not set with Nix
          # Also not an issue to have it here in plaintext because I have full disk encryption enabled on my system
          # initialPassword = "nixos"; # FIXME: Change user password after first login
          initialHashedPassword = "$y$j9T$Cg6Kvq06E/wawPxDcXTec/$g3BBNrrsroyJlbmTEl.Ff6xxx.k/smAHxfK5gV8NEA3";
          extraGroups = [
            # System
            "wheel"
            "systemd-journal"

            # Network management
            "networkmanager"

            # Containers/Virtualization
            "qemu"
            "kvm"
            "libvirtd"
            "docker"
            "podman"
            "vboxusers"

            "video" # Display/GPU access
            "audio" # Audio access
            "render" # GPU rendering
            "input" # Input devices
            "dialout" # Serial devices

            # Printer
            "scanner"
            "lp"

            # Misc
            "adbusers" # ADB
            "wireshark"
          ];
          shell = pkgs.fish;
          useDefaultShell = true;
        };
      };
    };
  };
}
