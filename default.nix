{ pkgs ? import <nixpkgs> {} }:

pkgs.callPackage (

{ lib
, runCommand
, runtimeShell
, ruby
, file
, pv
, coreutils
, gzip
, bzip2
, xz
, zstd
}:

# Build a wrapper-less version of the script.
# The shebang and PATH are set at the top of the script.
runCommand "burninate" {} ''
  mkdir -p $out/bin

  (cd $out/bin

  cat <<EOF > burninate
  #!${ruby}/bin/ruby
  EOF
  cat ${./burninate} >> burninate

  substituteInPlace burninate \
    --replace 'EXE_FILE = "file"' 'EXE_FILE = "${file}/bin/file"' \
    --replace 'EXE_ZCAT = "zcat"' 'EXE_ZCAT = "${bzip2}/bin/zcat"' \
    --replace 'EXE_XZCAT = "xzcat"' 'EXE_XZCAT = "${xz}/bin/xzcat"' \
    --replace 'EXE_BZCAT = "bzcat"' 'EXE_BZCAT = "${bzip2}/bin/bzcat"' \
    --replace 'EXE_ZSTDCAT = "zstdcat"' 'EXE_ZSTDCAT = "${zstd}/bin/zstdcat"' \
    --replace 'EXE_PV = "pv"' 'EXE_PV = "${pv}/bin/pv"' \
    --replace 'EXE_DD = "dd"' 'EXE_DD = "${coreutils}/bin/dd"'

  echo ":: Checking for unmet dependencies..."
  if grep -v '${builtins.storeDir}' burninate | grep '^EXE_'; then
    echo "... found unmet dependencies, aborting!"
    exit 1
  fi

  chmod +x  burninate
  )
''

) {}
