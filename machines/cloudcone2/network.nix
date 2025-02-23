{ pkgs, ... }:
{
  networking = {
    usePredictableInterfaceNames = false;
    interfaces.eth0.ipv4.addresses = [
      {
        address = "";
        prefixLength = 24;
      }
    ];
    defaultGateway = {
      address = "";
      interface = "eth0";
    };
    interfaces.eth0.ipv6.addresses = [
      {
        address = "";
        prefixLength = 64;
      }
    ];
    defaultGateway6 = {
      address = "";
      interface = "eth0";
    };
    # Encrypted DNS
    dhcpcd.extraConfig = "nohook resolv.conf";
    nameservers = [
      "127.0.0.1"
      "::1"
    ];
    timeServers = [
      "nts.netnod.se"
      "nts.time.nl"
    ];
  };

  # Encrypted DNS
  services.stubby = {
    enable = true;
    settings = pkgs.stubby.passthru.settingsExample // {
      resolution_type = "GETDNS_RESOLUTION_STUB";
      dns_transport_list = [ "GETDNS_TRANSPORT_TLS" ];
      tls_authentication = "GETDNS_AUTHENTICATION_REQUIRED";
      tls_query_padding_blocksize = 256;
      edns_client_subnet_private = 1;
      idle_timeout = 10000;
      listen_addresses = [
        "127.0.0.1"
        "0::1"
      ];
      round_robin_upstreams = 1;
      upstream_recursive_servers = [
        {
          address_data = "185.222.222.222";
          tls_auth_name = "dot.sb";
          tls_pubkey_pinset = [
            {
              digest = "sha256";
              value = "amEjS6OJ74LvhMNJBxN3HXxOMSWAriaFoyMQn/Nb5FU=";
            }
          ];
        }
        {
          address_data = "45.11.45.11";
          tls_auth_name = "dot.sb";
          tls_pubkey_pinset = [
            {
              digest = "sha256";
              value = "amEjS6OJ74LvhMNJBxN3HXxOMSWAriaFoyMQn/Nb5FU=";
            }
          ];
        }
        {
          address_data = "2a09::";
          tls_auth_name = "dot.sb";
          tls_pubkey_pinset = [
            {
              digest = "sha256";
              value = "amEjS6OJ74LvhMNJBxN3HXxOMSWAriaFoyMQn/Nb5FU=";
            }
          ];
        }
        {
          address_data = "2a11::";
          tls_auth_name = "dot.sb";
          tls_pubkey_pinset = [
            {
              digest = "sha256";
              value = "amEjS6OJ74LvhMNJBxN3HXxOMSWAriaFoyMQn/Nb5FU=";
            }
          ];
        }
      ];
    };
  };
}
