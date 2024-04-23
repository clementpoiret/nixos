{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # NixOS modules
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add inputs to the system's legacy channels
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix.settings = {
    # Enables flakes and new nix commands
    experimental-features = "nix-command flakes";
    # Dedup and optimizations
    auto-optimise-store = true;
  };

  # Bootloader settings
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-f167ddf9-c20d-4f2d-8cba-631436fc9fc4".device = "/dev/disk/by-uuid/f167ddf9-c20d-4f2d-8cba-631436fc9fc4";

  hardware = {
    opengl = {
      enable = true;
      # driSupport = true;
      # driSupport32Bit = true;
      # extraPackages = with pkgs; [
      #   vaapiVdpau
      #   libvdpau-va-gl
      # ];
    };
  };

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Timezone and locale
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  # X11
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
  };
  # TODO: REMOVE ONCE HYPRLAND IS FULLY FUNCTIONAL
  services.xserver.desktopManager.xfce.enable = true;

  # XDG Portals and screensharing in wayland
  services.dbus.enable = true;
  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
      ];
    };
  };

  # Setting up greetd
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # WARNING: Next ver. of Tuigreet will separate --sessions and --xsessions, and add --xsession-wrapper
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --asterisks --remember --remember-user-session --time --sessions ${config.services.xserver.displayManager.sessionData.desktops}/share/xsessions:${config.services.xserver.displayManager.sessionData.desktops}/share/wayland-sessions";
	user = "greeter";
      };
    };
  };

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Sound with pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # For touchpad support, if needed
  #services.xserver.libinput.enable = true;

  # Users
  users.users.clementpoiret = {
    isNormalUser = true;
    description = "Clement POIRET";
    extraGroups = ["networkmanager" "wheel"];
    openssh.authorizedKeys.keys = [
      # TODO: add ssh public keys if needed
    ];
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # SSH
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    curl
    hyprland-protocols
    pavucontrol
    polkit_gnome
    wget
    wayland-protocols
    wayland-utils
    wlroots
    wlr-randr
    wl-clipboard
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    zellij
  ];

  # System env variables
  environment.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    CLUTTER_BACKEND = "wayland";
    GTK_USE_PORTAL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
    POLKIT_AUTH_AGENT = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";

    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
  };

  system.stateVersion = "23.11";
}
