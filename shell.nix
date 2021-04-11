{pkgs ? import <nixpkgs> {}}:

with pkgs;

mkShell {
  buildInputs = [ swiProlog ];
  shellHook = "alias prolog=swipl";
}
