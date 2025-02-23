{
  imports = [
    ./disko-config.nix
    ./hardware.nix
    ./user.nix

    ../../modules/system/base.nix
    ../../modules/system/blacklist.nix
    ../../modules/system/ssh.nix
    ../../modules/system/zfs.nix

    ./services/postgres.nix
    ./services/samba.nix
    ./services/immich.nix
    ./services/syncthing.nix
    ./services/power-management.nix
  ];
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
  # Enable networking
  networking = {
    hostName = "homelab";
  };

  # Zerotier needs one controller to accept new nodes. Once accepted
  # the controller can be offline and routing still works.
  clan.core.networking.zerotier.controller.enable = false;
}
