# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot = {
  	loader = {
    		efi = {
			canTouchEfiVariables = true;
			};
    		systemd-boot = {
  			enable = true;
			consoleMode = "max";
			};
		};
	initrd ={
		kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
	};
	kernelPackages = pkgs.linuxPackages_latest;
	kernelParams = [
	"video=DP-1:2560x1440@60"
	"nvidia-drm.modeset=1"
	];
	};

  # Use latest kernel.
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # ly displaymanager
  services.displayManager.ly = {
  	enable = true;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  #networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Kyiv";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.leo = {
    isNormalUser = true;
    description = "leo";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [

  # must-have
  alacritty
  librewolf-bin
  discord
  telegram-desktop
  steam
  mpv #? do i need this
  vlc
  flatpak
  mullvad

  # system must-have
  zip
  unzip
  wget
  gnupg
  pavucontrol #? do i need this
  openssh
  git
  ueberzugpp

  # cursors
  rose-pine-hyprcursor
  rose-pine-cursor

  # hyprland
  hyprlock
  hypridle
  hyprlauncher #? do i need this
  wofi
  swww
  hyprcursor
  ashell

  # services
  iwd
  bluez
  dunst
  vsftpd
  ly

  # tui
  impala
  bluetui
  lf
  lftp
  neovim
  fastfetch
  fzf
  cmatrix
  cava
  pipes
  tty-clock
  dooit #? do i need this
  cl-wordle
  steam-tui
  toilet
  cowsay
  oneko
  thokr
  grc
  lazyssh

  # fish
  fish
  fishPlugins.grc
  fishPlugins.hydro
  fishPlugins.forgit
  fishPlugins.fzf-fish
  fishPlugins.done
  ];

  # Fonts
  fonts.packages = with pkgs; [
  nerd-fonts.symbols-only
  noto-fonts
  noto-fonts-cjk-sans
  noto-fonts-color-emoji
  liberation_ttf
  fira-code
  fira-code-symbols
  mplus-outline-fonts.githubRelease
  dina-font
  proggyfonts
  ];



  # Nvidia proprietary drivers by ChatGPT
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    open = false;       # отключает open-вариант (мы хотим именно проприетарный)
    modesetting.enable = true;  # включить kernel modesetting (нужно для Wayland/графики)
  };



  hardware.graphics = {
    enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.flatpak.enable = true;
  services.openssh.enable = true;

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
  system.stateVersion = "25.11"; # Did you read the comment?

  # Fish
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Steam
  programs.steam.enable = true;

  # Hyprland
  programs.hyprland.enable = true;
  xdg.portal = {
  enable = true;
  extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; # Fixes OpenURI and cursor themes in flatpaks
};
  environment.sessionVariables = {
    # XWayland / Electron (Discord и т.п.)
    XCURSOR_THEME = "rose-pine-cursor";
    XCURSOR_SIZE  = "24";

    # Hyprland / Wayland-native
    HYPRCURSOR_THEME = "rose-pine-hyprcursor";
    HYPRCURSOR_SIZE  = "24";

    # часто помогает Electron-приложениям реально идти в Wayland
    NIXOS_OZONE_WL = "1";
  };
}
