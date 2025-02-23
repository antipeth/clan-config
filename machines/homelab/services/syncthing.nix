{
  services = {
    syncthing = {
      enable = true;
      dataDir = "/backup";
      user = "atp";
      group = "users";
      openDefaultPorts = true;
      guiAddress = "192.168.6.173:8384";
      # cert = "Path to the cert.pem file";
      # key = "Path to the key.pem file";
      settings = {
        devices = {
          asusbook = {
            id = "PNXRTAP-4SZD2AF-KHARWWZ-6YBM4P6-XUV2AN2-2HEAUFQ-LY7Z2UM-JANGGQV";
          };
        };
        folders = {
          "/backup/sync" = {
            id = "default";
            devices = [
              "asusbook"
            ];
            versioning.type = "trashcan";
          };
        };
        options = {
          globalAnnounceEnabled = false;
          localAnnounceEnabled = true;
          relaysEnabled = false;
        };
      };
    };
  };
  networking.firewall = {
    # for NFSv3; view with `rpcinfo -p`
    allowedTCPPorts = [
      8384
    ];
  };
}
