{ pkgs, ... }:

{
  # https://github.com/nix-community/home-manager/pull/2408
  environment.pathsToLink = [ "/share/fish" ];

  users.users.cliff = {
    isNormalUser = true;
    home = "/home/cliff";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.fish;
    hashedPassword = "$y$j9T$ODvsmRwHMeIpjUeadD0Ax/$f38ZXFhUfc/jg48fgPQSikuQWOAVu/3lE.IOyUViZD8";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICM1bWwiDcHHa4/OkEsmOtM5qzrGpvRwrovfYAV+8Fa6 cliff"
    ];
  };

  nixpkgs.overlays = import ../../lib/overlays.nix ++ [
    (import ./vim.nix)
  ];
}
