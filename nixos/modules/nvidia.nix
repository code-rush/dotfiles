{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
  };

  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs; [
    mesa-demos		#glxinfo, glxgears
    pciutils
  ];
}
