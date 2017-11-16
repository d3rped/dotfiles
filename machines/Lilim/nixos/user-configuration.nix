{
  users.mutableUsers = false;
  users.extraUsers = {
    derped = { 
      isNormalUser = true;
      home = "/home/derped";
      createHome = true;
      description = "default user... Well I'am the only user after all";
      extraGroups = [ "derped" "audio" "wheel" "network" "lp" "scanner" "video" ];
      uid =  1337;
      shell = "/run/current-system/sw/bin/zsh";
      initialHashedPassword = "SOMEHASH";
      };
  };

  users.extraGroups.derped = {
    name = "derped";
    members = [ "derped" ];
  };

}
