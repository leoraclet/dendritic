{
  flake.nixosModules.printer = { pkgs, ... }: {
    services = {
      ipp-usb.enable = true;
      printing = {
        enable = true;
        drivers = with pkgs; [
          cups-filters
          cups-browsed
          cnijfilter2
          gutenprint
          gutenprintBin
          hplip
          hplipWithPlugin
          splix
          brlaser
        ];
        extraConf = ''
          ErrorPolicy retry-job
        '';
        browsedConf = ''
          Browsing On
          BrowseOrders allow,deny
          BrowseAllow all
          BrowseDNSSDSubTypes _cups,_print
          BrowseLocalProtocols all
          BrowseRemoteProtocols all
          CreateIPPPrinterQueues All
          BrowseProtocols all
          Allow 127.0.0.1
          Allow localhost
        '';
        listenAddresses = [ "*:631" ];
        allowFrom = [ "all" ];
        browsing = true;
        defaultShared = true;
        openFirewall = true;
      };
      # Network discovery, mDNS
      # With this enabled, you can access your machine at <hostname>.local
      # it's more convenient than using the IP address.
      # https://avahi.org/
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
        publish = {
          enable = true;
          domain = true;
          userServices = true;
        };
      };
    };
  };
}
