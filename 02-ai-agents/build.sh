#!/bin/bash
# Assembles the course from parts.
# Run from the course directory: bash build.sh
#
# NOTE: This build script is currently non-functional because the `modules/`
# source directory is not included in the repository.
# `index.html` is the pre-built final product — open it directly in your browser.
# If you want to rebuild from source, recreate the `modules/` directory by
# splitting `index.html` back into per-module HTML fragments.
set -e
cat _base.html modules/*.html _footer.html > index.html
echo "Built index.html — open it in your browser."
