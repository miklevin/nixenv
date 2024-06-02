{ pkgs ? import <nixpkgs> {} }:

let
  # Explicitly allow unfree packages here
  pkgs = import <nixpkgs> {
    config = {
      allowUnfree = true;
    };
  };
in
pkgs.mkShell {
  buildInputs = [
    pkgs.python311
    pkgs.virtualenv
    (pkgs.python311.withPackages (ps: with ps; [
      beautifulsoup4
      flake8
      ipython
      ipywidgets
      jupyterlab
      nltk
      numpy
      openpyxl
      pandas
      pip
      pytorch-bin
      requests
      scikitlearn
      scipy
      statsmodels
      sympy
      tensorflow
      tldextract
      tornado
      transformers
      xlsxwriter
    ]))
  ];

  shellHook = ''
    export NIXPKGS_ALLOW_UNFREE=1

    # Check if the virtual environment already exists
    if [ ! -d "venv" ]; then
      # Create a virtual environment if it doesn't exist
      virtualenv venv
    fi

    # Activate the virtual environment
    source venv/bin/activate
  '';
}

