#!/bin/bash
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
