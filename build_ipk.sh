#!/bin/bash

# Variables
REPO_URL="https://github.com/Jiteshprm/e2m3u2bouquet-plugin.git"
PLUGIN_NAME="e2m3u2bouquet"
PACKAGE_NAME="enigma2-plugin-extensions-$PLUGIN_NAME"
VERSION="1.0.0"
ARCHITECTURE="all"
MAINTAINER="Jitesh Prm"
DESCRIPTION="An Enigma2 plugin to convert m3u to bouquets"
SECTION="multimedia"
PRIORITY="optional"

# Temporary directories
WORK_DIR="$(pwd)/work"
OUTPUT_DIR="$(pwd)/output"
CONTROL_DIR="$WORK_DIR/CONTROL"
PLUGIN_DIR="$WORK_DIR/usr/lib/enigma2/python/Plugins/Extensions/$PLUGIN_NAME"

# Clean up previous build
rm -rf "$WORK_DIR" "$OUTPUT_DIR"
mkdir -p "$PLUGIN_DIR" "$CONTROL_DIR" "$OUTPUT_DIR"

# Clone the repository
echo "Cloning the repository..."
git clone "$REPO_URL" "$PLUGIN_DIR"

# Create the control file
echo "Creating control file..."
cat <<EOF > "$CONTROL_DIR/control"
Package: $PACKAGE_NAME
Version: $VERSION
Architecture: $ARCHITECTURE
Maintainer: $MAINTAINER
Description: $DESCRIPTION
Section: $SECTION
Priority: $PRIORITY
EOF

# Build the .ipk package
echo "Building the .ipk package..."
opkg-build "$WORK_DIR" "$OUTPUT_DIR"

# Final message
if [ $? -eq 0 ]; then
    echo "Package built successfully!"
    echo "Find your package at: $OUTPUT_DIR/${PACKAGE_NAME}_${VERSION}_${ARCHITECTURE}.ipk"
else
    echo "Package build failed!"
fi
