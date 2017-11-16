{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qucs
  ];
}
