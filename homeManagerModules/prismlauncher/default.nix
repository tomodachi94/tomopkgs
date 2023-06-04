{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.programs.prismlauncher;

  iniFormat = pkgs.formats.ini { };

in {
  meta.maintainers = [ maintainers.tomodachi94 ];

  options = {
    programs.prismlauncher = {
      enable = mkEnableOption "the open-source Minecraft launcher";
      package = mkPackageOption pkgs "prismlauncher" { };

      settings = mkOption {
        type = iniFormat.type;
        default = { };
        description = ''
          Configuration written to
          <filename>$XDG_DATA_HOME/PrismLauncher/prismlauncher.cfg</filename>
        '';
      };

    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.dataFile."PrismLauncher/prismlauncher.cfg".source =
      iniFormat.generate "prismlauncher-config" cfg.settings;
  };
}
