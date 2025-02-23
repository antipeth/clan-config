{
  config,
  pkgs,
  host,
  ...
}:
{
  services = {
      syncthing = {
          enable = true;
      };
  };
  networking.firewall = {
    allowedTCPPorts = [ 22000 ];
    allowedUDPPorts = [ 22000 21027 ];
  };
}
