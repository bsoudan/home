home-manager: pkgs: {

    homeDefinition = file: home-manager.lib.homeManagerConfiguration {
       inherit pkgs;

       modules = [
         file
       ];
     };

}
