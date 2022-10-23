{ pkgs, lib, config, ... }:

with lib;
{
  # Make flakes provide <nixpkgs> to make the evaluations pure
  # imports = [
  #   <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
  # ];

  config = {
    fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      autoResize = true;
    };

    boot = {
      growPartition = true;
      kernelParams = [ "console=ttyS0" "boot.shell_on_fail" ];
    };

    services.getty.autologinUser = "root";
    users.extraUsers.root.password = "";

    environment.systemPackages = with pkgs; [ 
      neovim
      kubernetes
      kubectl
    ];

    networking = {
      hostName = "controller";
    };

    system.stateVersion = "22.11";

    # copySystemConfiguration seems useless and doesn't work for flakes
    # system.copySystemConfiguration = true;
  };
}
