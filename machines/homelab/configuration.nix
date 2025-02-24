{ config, ... }:
{
  imports = [
    ./user.nix
    ./network.nix

    ../../modules/system/base.nix
    ../../modules/system/blacklist.nix
    # ../../modules/system/clan.nix
    ../../modules/system/min.nix
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
  clan.core.networking.targetHost = "homelab";
}
