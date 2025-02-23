{ pkgs, ... }:
{
  imports = [
    ./disko-config.nix
    ./hardware.nix
    ./network.nix
    ./user.nix

    ../../modules/system/base.nix
    ../../modules/system/ssh.nix
    # ../../modules/system/zfs.nix
    # ../../modules/system/blacklist.nix

    # ./services/postgres.nix
    # ./services/samba.nix
    # ./services/immich.nix
    # ./services/syncthing.nix
    # ./services/power-management.nix
  ];
  boot = {
    kernelPackages = pkgs.linuxPackages-libre;
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        configurationLimit = 10;
        enable = true;
        device = "nodev";
      };
    };
  };
  # Enable networking
  networking = {
    hostName = "cloudcone2";
  };

  # Zerotier needs one controller to accept new nodes. Once accepted
  # the controller can be offline and routing still works.
  clan.core.networking.zerotier.controller.enable = false;
}
