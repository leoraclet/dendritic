{
  flake.nixosModules.virtualization = { pkgs, ... }: {

    # https://wiki.nixos.org/wiki/Networking#Virtualization
    networking = {
      firewall = {
        enable = true;

        # Allows the entire interface through the firewall.
        # trustedInterfaces = [ "virbr0" ];

        # Allows individual ports through the firewall.
        interfaces = {
          virbr0 = {
            allowedUDPPorts = [
              # DNS
              53
              # DHCP
              67
              # You may want to allow more ports such as ipv6 and other services here.
            ];
          };
        };
      };
      nat = {
        enable = true;

        internalInterfaces = [ "virbr0" ];
      };
    };

    systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];

    # Virt Manager
    programs.virt-manager.enable = true;
    services.spice-vdagentd.enable = true;

    # https://nixos.wiki/wiki/NixOS:nixos-rebuild_build-vm
    virtualisation = {
      vmVariant = {
        # following configuration is added only when building VM with build-vm
        virtualisation = {
          memorySize = 4096; # Use 2048MiB memory.
          cores = 4;
        };
      };

      spiceUSBRedirection.enable = true;
      containers = {
        enable = true;
        storage.settings = {
          # storage = {
          #   driver = "overlay";
          #   runroot = "/run/containers/storage";
          #   graphroot = "/var/lib/containers/storage";
          #   rootless_storage_path = "/tmp/containers-$USER";
          #   options.overlay.mountopt = "nodev,metacopy=on";
          # };
        };
      };

      vmware.host.enable = true;

      libvirtd = {
        enable = true;

        qemu = {
          swtpm.enable = true;
          vhostUserPackages = with pkgs; [ virtiofsd ];
          runAsRoot = true;
        };
      };

      oci-containers.backend = "podman";
      podman = {
        enable = true;
        dockerCompat = true;
        dockerSocket.enable = true;
        autoPrune = {
          enable = true;
          flags = [ "--all" ];
        };
        defaultNetwork.settings.dns_enabled = true;
      };

      # Disable docker because with use Podman instead
      docker = {
        enable = false;
        autoPrune.enable = true;
        rootless = {
          enable = true;
          setSocketVariable = true;
        };
        daemon.settings = {
          pruning = {
            enabled = true;
            interval = "24h";
          };
        };
      };

      waydroid = {
        enable = true;
        # Newer kernel versions may need
        package = pkgs.waydroid-nftables;
      };

      # VirtualBox
      # https://nixos.wiki/wiki/VirtualBox
      virtualbox = {
        host = {
          enable = false;
          enableExtensionPack = false;
        };
        guest = {
          enable = false;
          dragAndDrop = false;
        };
      };
    };

    users.extraGroups.vboxusers.members = [ "leonne" ];

    environment.systemPackages = with pkgs; [
      OVMF
      podman-compose
      qemu
      qemu_kvm
      quickemu
      docker-compose
      dnsmasq
      # android-tools
    ];

    environment.extraInit = ''
      if [ -z "$DOCKER_HOST" -a -n "$XDG_RUNTIME_DIR" ]; then
        export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"
      fi
    '';
  };
}
