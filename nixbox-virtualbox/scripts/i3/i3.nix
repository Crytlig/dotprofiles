{ config, pkgs, callPackage, ... }:

{

  services.xserver = {
      enable = true;

      desktopManager = {
        xterm.enable = false;
      };

      displayManager = {
          defaultSession = "none+i3";
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu # application launcher most people use
          i3status # gives you the default i3 status bar
          i3lock # default i3 screen locker
          i3blocks # if you are planning on using i3blocks over i3status
      ];
      };
    };

  # locales
  i18n.extraLocaleSettings = {
    LC_ALL = "en_US.UTF8";
    LANG = "en_US.UTF8";
    LC_MESSAGES = "en_US.UTF-8";
    LC_TIME = "en_DK.UTF-8";
  };

  time.timeZone = "Europe/Copenhagen";

  # Enable zsh
  programs.zsh.enable = true;

  # local user
  users.users.cliff = {
    description     = "Cliff";
    name            = "cliff";
    home            = "/home/cliff";
    isNormalUser    = true;
    shell           = pkgs.zsh;
    password        = "vagrant";
    createHome      = true;
    extraGroups     = ["wheel" "vboxsf" "users"] ;
    openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key"
    ];
  };

  environment.systemPackages = with pkgs; [
    git
    neovim
  ];
}
