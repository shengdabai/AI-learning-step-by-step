#!/bin/bash
# NOTE: This build script is currently non-functional because the `modules/`
# source directory is not included in the repository.
# `index.html` is the pre-built final product — open it directly in your browser.
# If you want to rebuild from source, recreate the `modules/` directory by
# splitting `index.html` back into per-module HTML fragments.
set -e
python3 -c "
header = open('_base.html').read()
mods = ''
import glob
for f in sorted(glob.glob('modules/*.html')):
    mods += open(f).read()
mods += open('_footer.html').read()
open('index.html', 'w').write(header.replace('@@MODULES@@', mods))
print('Built index.html — open it in your browser.')
"
