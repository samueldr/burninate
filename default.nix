{
  pkgs ? import <nixpkgs> {}
}:

let
  inherit (pkgs) ruby runCommandNoCC runtimeShell;
  inherit (pkgs.lib) makeBinPath;
  runtimePath = makeBinPath (with pkgs;[
    coreutils
    file
    pv
    zstd
  ]);
in

# Build a wrapper-less version of the script.
# The shebang and PATH are set at the top of the script.
runCommandNoCC "burninate" {
  inherit runtimePath;
} ''
  mkdir -p $out/bin

  cat <<EOF > $out/bin/burninate
  #!${ruby}/bin/ruby
  ENV["PATH"] = "$runtimePath"

  EOF

  cat ${./burninate} >> $out/bin/burninate

  chmod +x  $out/bin/burninate
''
