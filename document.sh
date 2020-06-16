#!/usr/bin/env bash
#
# Puts the API docs generated by Typedoc into the README

cd "$(dirname "$0")"

# Generate new API docs at docs/typedoc/README.md
npx typedoc src/openmrs-esm-module-config.ts

# Delete the current API docs
sed -i '/<!-- API -->/,/<!-- ENDAPI -->/{/<!-- API -->/!{/<!-- ENDAPI -->/!d;};}' README.md

# Generate the TOC, not including the API docs (but including the API header)
sed -i 's/^# API/## API/' README.md
npx markdown-toc -i --maxdepth 2 README.md
sed -i 's/^## API/# API/' README.md

# Add the new API docs back in
awk '/<!-- API -->/{print;system("tail -n+5 docs/typedoc/README.md");next} 1' README.md > tmpreadme && mv tmpreadme README.md
