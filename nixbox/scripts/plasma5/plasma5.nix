{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Disable a lot of the default applications that are now needed
  services.xserver.desktopManager.plasma5.excludePackages = with pkgs.libsForQt5; [
    elisa
    gwenview
    okular
    oxygen
    khelpcenter
    konsole
    plasma-browser-integration
    print-manager
  ];

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

  # local user. Don't forget to set a password with ‘passwd’.
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
