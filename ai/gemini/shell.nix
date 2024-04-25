with import <nixpkgs> { }; let
  pythonPackages = python3Packages;
in
pkgs.mkShell
rec {
  name = "python311evn";

  buildInputs = with pythonPackages; [
    python
    pip

    venvShellHook

    pycrypto
    taglib
    openssl
    git
    libxml2
    libxslt
    libzip
    zlib
    pkgs.stdenv.cc.cc.lib

    pkgs.poetry
  ];

  venvDir = "venv310";

  LD_LIBRARY_PATH = lib.makeLibraryPath [ gcc-unwrapped zlib libglvnd glib ];

  postShellHook = ''
  '';
}
