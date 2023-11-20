# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  nixpkgs.config.permittedInsecurePackages = ["qtwebkit-5.212.0-alpha4"];
  # Bootloader.
   boot = {
    blacklistedKernelModules = [ "snd_pcsp" ];
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.cleanOnBoot = true;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [
      "exfat"
    ];
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "br";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Define a user account. Don't forget to set a password with ‘passwd’.
 users.defaultUserShell = pkgs.zsh;	
 users.users.vinicius = {
    isNormalUser = true;
    description = "vinicius";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  pkgs.waybar
  pkgs.dunst
  libnotify
  mpvpaper
  kitty
  rofi-wayland
  mpd
  mpv
  firefox
  wofi
  spotify
  zsh
  pavucontrol
  pulseaudio
  git
  nodejs
  python3
  neofetch
  gnumake
  pkgs.go
  pkgs.home-manager
  pkgs.qt5.qtgraphicaleffects
  pkgs.qt5.qtquickcontrols2
  pkgs.qt5.qtsvg
  eza
  bat
  (callPackage /etc/nixos/nixpkgs/sddmthemes/sugardark.nix {}).sddm-sugar-dark
  pkgs.appimage-run
  keepassxc
  pkgs.play-with-mpv
  pkgs.nwg-look
  glib
  gcc
  dolphin
  killall
  stremio
  vscode
  cava
  xorg.xev
  wev
  htop
  pkgs.brightnessctl
  stow
  pkgs.grim
  pkgs.slurp
  pkgs.wl-clipboard
  pkgs.gh
  typescript
  pkgs.jdk21
  meson
  ninja
  chromium
  pkgs.yt-dlp
  emacs
  open-in-mpv
  pkgs.desktop-file-utils
  feh
  spotify-cli-linux
];
  	
 
  #Config Hyprland
  xdg.portal.enable=true;
  xdg.portal.extraPortals=[ pkgs.xdg-desktop-portal-gtk ];

  programs.hyprland.enable=true;
  programs.firefox.nativeMessagingHosts.ff2mpv=true;		
  programs.zsh.enable=true; 
  programs.thunar.enable = true;
	
  services.gvfs.enable = true;
  services.xserver.displayManager.sddm.enable = true; #This line enables sddm
  services.xserver.enable = true; # Might need this for Xwayland  

  # Temas
  services.xserver.displayManager.sddm.theme = "sugar-dark";

  #N mexer
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  sound.enable = true;
  
  nixpkgs.config.pulseaudio = true;
	
  services = {
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa = {
       enable = true;
        support32Bit = true;
      };
      jack.enable = true;
    };
  };

  #Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
