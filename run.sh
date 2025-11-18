#!/usr/bin/env bash
set -e

echo "Vérification de la configuration..."
python3 /app/options.py || exit 1

echo "Listing contents of /config before write test:"
ls -l /config || echo "Failed to list /config"

echo "Testing write access to /config..."

if touch /config/custom_components/write_test.txt 2>/dev/null; then
  echo "Write test PASSED"
  rm /config/custom_components/write_test.txt
else
  echo "Write test FAILED: /config/custom_components is read-only"
  exit 1
fi

echo "Copying custom component to /config/custom_components/surikat-editor"

mkdir -p /config/custom_components/surikat-editor

cp -r /app/custom_components/surikat-editor/* /config/custom_components/surikat-editor/

echo "Custom component copied successfully."

while true; do sleep 60; done