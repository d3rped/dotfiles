# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./emacs.nix
      ./pkgs-unfree.nix
      ./hardware-configuration.nix
      ./user-configuration.nix
      ./zsh.nix
      ./uniProg.nix
    ];

  nix = {
    maxJobs = 4;
    buildCores = 1;
    autoOptimiseStore = true;
    sshServe.enable = false;
    #sshServe.keys = [];
    useSandbox = false;
  };

  system.autoUpgrade.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_4_13;
#    initrd.kernelModules = [ "hid-multitouch" ];
    initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
#    kernelModules = [ "kvm-intel" "hid-multitouch" ];

    kernelParams = [
      #"resume=/dev/mapper/lvm--quatermain-swap"
      "noresume"
    ];

    kernelPatches = [
#    { name = "0002-ipts";
#      patch = ../pkgs/surface/0002-ipts.patch;
#    }
#
#    { name = "0003-wifi";
#      patch = ../pkgs/surface/0003-wifi.patch;
#    }
#
#    { name = "0004-sd.patch";
#      patch = ../pkgs/surface/0004-sd.patch;
#    }

#    { name = "0005-hid";
#      patch = ../pkgs/surface/0005-hid.patch;
#    }

      { name = "IPTS";
        patch = ../pkgs/surface-patches/ipts-4.13.patch;
        extraConfig = "INTEL_IPTS m";
      }
      { name = "mwifiex-fix";
        patch = ../pkgs/surface-patches/mwifiex-fix.patch;
        extraConfig = "CFG80211_DEFAULT_PS n";
      }
    ];
  };


  powerManagement.enable = true;

  environment = {
    #systemPackages = [ (import ../pkgs/surface-pro-firmware/default.nix) ];
    variables = {
      GDK_SCALE = "2"; # Scale UI elements
      GDK_DPI_SCALE = "0.5"; # Reverse scale the fonts
      XCURSOR_SIZE = "112" ;
      EDITOR="nano";
      WINEDLLOVERRIDES="winemenubuilder.exe=d";
      LC_CTYPE="zh_CN.UTF-8";
    };
    etc."systemd/sleep.conf".text = ''
      [Sleep]
      SuspendState=freeze
    '';
  };

  # Powertop suggested options
  boot.extraModprobeConfig = "options snd_hda_intel power_save=1 power_save_controller=Y";
  boot.kernel.sysctl = {
    "kernel.nmi_watchdog" = 0;
    "vm.dirty_writeback_centisecs" = 1500;
  };







  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  networking = {
    hostName ="Lilim";
#    dhcpcd.enable = true;
    resolvconfOptions = [ "nameserver 8.8.8.8" ];
    networkmanager.enable = false;
    wireless = {
      enable = false;
      networks = {
      };

      userControlled = {
        enable = true;
        group = "network";
      };
    };
    firewall = {
      enable = true;
      allowPing = false;
#      allowedUDPPorts = [];
#      allowedUDPPortRanges = []; # example [ { from = 8999; to = 9003; } ];
#      allowedTCPPorts = [];
#      allowedTCPPortRanges = [];
#      extraCommands = '''';
    };
  };

  # Select internationalisation properties.
   i18n = {
     consoleFont = "Lat2-Terminus16";
     consoleKeyMap = "de";
     defaultLocale = "en_US.UTF-8";
     inputMethod = {
       enabled = "fcitx";
       fcitx.engines = with pkgs.fcitx-engines; [ chewing mozc ];
     };
   };

 fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts # Microsoft free fonts
      inconsolata # monospaced
      ubuntu_font_family
      dejavu_fonts
      source-han-sans-simplified-chinese
      source-han-sans-traditional-chinese
      noto-fonts-cjk
      wqy_microhei
    ];
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget  

#  environment.python3 = with pkgs; [
#    python36Full
#    python36Packages.bpython
#  ];

  environment.systemPackages = with pkgs; [
#     (import ../pkgs/surface-patches/default.nix)
     anki
     audacious
     bundler
     bundix
     calibre
     chromium
     cryptsetup
     darktable
     dhcpcd
     dmenu
     evince
     feh
     ffmpeg-full
     firefox
     gcc7
     getxbook
     gimp-with-plugins
     git
     glxinfo
     gnome3.adwaita-icon-theme
     gnome3.dconf
     gnome3.eog
     gnome3.gnome-disk-utility
     gnome3.gnome_terminal
     gparted
     gptfdisk
     htop
     inkscape
     iptables
     krita
     libav
     libva-full
     mpv
     netcat
     networkmanager
     nextcloud-client
     nix-index
     nix-prefetch-git
     nix-repl
     nix-zsh-completions
     nmap
     nox
     ntfs3g
     octave
     oh-my-zsh
     p7zip
     parted
     patchelf
     pavucontrol
     pciutils
     pcmanfm
#     pidgin
#     pidginotr
#     pidgin-skypeweb
     playerctl
     polkit
     polkit_gnome
     ponysay
#     purple-plugin-pack
     python36Full
     python36Packages.bpython
     python36Packages.py3status
     python36Packages.numpy
     python36Packages.plotly
#     python36Packages.pip2nix
     qrencode
     redshift
     rfkill
     ruby
     scrot
     simple-scan
#     skypeforlinux
     sysvtools
     tdesktop
     telegram-purple
     texlive.combined.scheme-full
     thunderbird
     transmission_gtk
     unrar
     unzip
     usbutils
     vaapiIntel
     wget
     wine
     winetricks
     wirelesstools
     wpa_supplicant
     xarchiver
     x264
     x265
     xdg_utils
     xorg.xbacklight
     xorg.xf86videointel
     xorg.xinit
     xorg.xinput
     xorg.xkill
     xorg.xmessage 
     youtube-dl
     zlib
     zsh
   ];



  hardware = {
    #firmware = [ pkgs.surface-pro-firmware ];
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
    enableKSM = true;
    opengl = { 
      driSupport = true;
      extraPackages = with pkgs; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
      driSupport32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel libvdpau-va-gl vaapiVdpau ];
    };

    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
      zeroconf.discovery.enable = true;
    };

    bluetooth = { 
      enable = true;
      powerOnBoot = true;    
    };

    sane.enable = true;
  };



#  nixpkgs.config.packageOverrides = pkgs: rec {
#    suld = pkgs.samsung-unified-linux-driver.overrideAttrs (oldAttrs: rec {
#      name = "samsung-UnifiedLinuxDriver-${version}";
##      version = "1.00.37";
#      version = "4.01.317";
#      src = pkgs.fetchurl {
#        url = "http://www.bchemnet.com/suldr/driver/UnifiedLinuxDriver-${version}.tar.gz";
##        sha256 = "6b85253ea0bb51d241f6fd665ff0d39464cdad87084802a77a385c707fa2c664";
#      sha256 = "a01b83b99cb77068553685c65d8e62678feb450f26a02cfbc02dbc8bf7bf63ef";
#      };
#    });
#  };

  nixpkgs.config = {
    mpv.vaapiSupport = true;
  };
  fonts.fontconfig.dpi = 267;


  services = {
    locate.enable = true;
#    printing = { 
#      enable = true;
#      drivers = [ pkgs.gutenprint pkgs.splix ];
#    }; 
    udisks2.enable = true;

    acpid.enable = true;
    logind.extraConfig = ''
      HandlePowerKey=shutdown
      HandleLidSwitch=shutdown
    '';

    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", DEVPATH=="*/0000:0?:??.?", TEST=="power/control", ATTR{power/control}="auto"
      ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="auto"
      # handle typing cover disconnects
      # https://www.reddit.com/r/SurfaceLinux/comments/6axyer/working_sp4_typecover_plug_and_play/
      #ACTION=="add", SUBSYSTEM=="usb", ATTR{product}=="Surface Type Cover", RUN+="${pkgs.kmod}/bin/modprobe -r i2c_hid && ${pkgs.kmod}/modprobe i2c_hid"

      ## IPTS Touchscreen (SP2017)
      #SUBSYSTEMS=="input", ATTRS{name}=="ipts 1B96:001F SingleTouch", ENV{ID_INPUT_TOUCHSCREEN}="1", SYMLINK+="input/touchscreen"
      ## IPTS Pen (SP2017)
      #SUBSYSTEMS=="input", ATTRS{name}=="ipts 1B96:001F Pen", SYMLINK+="input/pen"

      ## IPTS Pen (SP4)
      #SUBSYSTEMS=="input", ATTRS{name}=="ipts 1B96:006A Pen", SYMLINK+="input/pen"
    '';


    gnome3 = {
      at-spi2-core.enable = true;
      gnome-disks.enable = true;
      gnome-terminal-server.enable = true;
      gvfs.enable = true;
    };
                                            

    xserver = {
      enable =  true;
      monitorSection = ''
        DisplaySize 260 173
      '';

      layout = "de";
      modules = [ pkgs.xf86_input_wacom ];
      wacom.enable = true;
      multitouch = {
        enable = true;
        invertScroll = true;
      };

      displayManager = {
        slim.enable = true;
        auto.user = "derped";
        auto.enable = true;
      };
      windowManager.i3.enable = true;
      windowManager.default = "i3";
      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          enableXfwm = true;
          noDesktop = false;
          extraSessionCommands = "";
          thunarPlugins = [ pkgs.xfce.thunar-archive-plugin ];
        };
        default = "none";
      };
      videoDrivers = [ "intel" ];

      libinput = {
        enable = true;
        tapping = true;
        disableWhileTyping = true;
        naturalScrolling = false;
        horizontalScrolling = true;
	tappingDragLock = false;
      };
   };

#    redshift = {
#      enable = true;
#      latitude = "51.0504";
#      longitude = "13.7373";
#    };
  };


  security.polkit.enable = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.09";

}
