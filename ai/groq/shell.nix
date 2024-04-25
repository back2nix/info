with import <nixpkgs> { }; let
  pythonPackages = python3Packages;
in
pkgs.mkShell
rec {
  name = "impurePythonEnv";
  # format = "pyproject";
  # format = "setuptools";

  # PyExecJS = pythonPackages.buildPythonPackage {
  #   name = "PyExecJS-1.5.1";
  #   src = fetchurl {
  #     url = "https://pypi.python.org/packages/ba/8e/aedef81641c8dca6fd0fb7294de5bed9c45f3397d67fddf755c1042c2642/PyExecJS-1.5.1.tar.gz";
  #     sha256 = "0p2hkxv7mzxvbw6c0217r68shmw13zbhmp3vzy1q34bn143ivk1l";
  #   };
  #   propagatedBuildInputs = with pythonPackages; [ six ];
  #   doCheck = false;
  # };

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

    # pkgs.gcc6
    # pkgs.gcc-unwrapped
    # cython
    # grpclib

    pkgs.poetry
  ];

  venvDir = "venv310";

  LD_LIBRARY_PATH = lib.makeLibraryPath [ gcc-unwrapped zlib libglvnd glib ];

  postShellHook = ''
    # LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${stdenv.cc.cc.lib}/lib/:$PYTHON_LD_LIBRARY_PATH
    # pip install -r requirements.txt
    # poetry install --no-root
    # poetry lock
  '';
}
