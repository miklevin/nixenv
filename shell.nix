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
      coverage
      cython
      flake8
      flax
      guppy3
      ipython
      ipywidgets
      jupyterlab
      mypy
      nltk
      numpy
      numpy-stl
      openpyxl
      pandas
      pillow
      pip
      pytest
      pytorch-bin
      requests
      scikitlearn
      scipy
      simplenote
      statsmodels
      sympy
      tensorflow
      tldextract
      torchvision-bin
      tornado
      transformers
      typer
      types-pillow
      types-requests
      wheel
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

