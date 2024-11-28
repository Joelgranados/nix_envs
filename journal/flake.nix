{
  description = "journaling flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    env_shell.url = "github:Joelgranados/nix_envs?dir=env_shell";
  };

  outputs = { self, nixpkgs, env_shell, ... }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      system = "x86_64-linux";
      ccache_vars = import ../ccache/ccache.nix { inherit pkgs; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        shellPkgs = with pkgs;
        [
          gnumake
          pandoc
          glow # to visualize mark down
          clang-tools
        ];
        packages = self.devShells.${system}.default.shellPkgs;

        shellHook = ''
        ''
        + env_shell.devShells.${system}.default.shellHook
        ;
      };
    };
}
