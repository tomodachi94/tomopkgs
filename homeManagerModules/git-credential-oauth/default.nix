{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.programs.git-credential-oauth;

in {
  meta.maintainers = [ maintainers.tomodachi94 ];

  options = {
    programs.git-credential-oauth = {
      enable = mkEnableOption "Git authentication handler for OAuth";

      package = mkPackageOption pkgs "git-credential-oauth" { };

      enableGitCredentialHelper =
        mkEnableOption "the Git credential handler for OAuth" // {
          default = true;
      };

    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    programs.git.extraConfig.credential.helper =
      mkIf cfg.enableGitCredentialHelper
      [ "${cfg.package}/bin/git-credential-oauth" ];
  };
}
