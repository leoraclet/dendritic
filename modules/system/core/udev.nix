{
  flake.nixosModules.udev = { ... }: {
    services.udev = {
      enable = true;
      extraRules = ''
        KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
      '';
    };
  };
}
