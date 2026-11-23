#!/usr/bin/env bash
#
# Apply KDE-specific modifications for Bazzite.
#
# Configure KDE desktop environment: Installs/removes/swaps packages
# and configures default layout/wallpaper.
#
set -xeuo pipefail

# -- Install KDE packages --
# Install required KDE packages, input method frameworks, and supporting tools.
echo "==> Installing KDE packages..."

dnf5 -y install \
    steamdeck-kde-presets-desktop \
    gnome-disk-utility \
    krunner-yafti \
    krdc \

# -- Remove unnecessary packages --
# Remove default Fedora KDE packages that conflict with Bazzite customization.
echo "==> Removing unnecessary packages..."

dnf5 -y remove \
    plasma-drkonqi \
    plasma-welcome{,-fedora} \
    plasma-discover-kns \
    plasma-setup \
    kcharselect \
    kde-partitionmanager \
    plasma-discover{,-libs} \
    xwaylandvideobridge

# -- Configure layout and wallpaper --
# Apply Bazzite pin configuration, set default wallpapers, and clean up legacy files.
echo "==> Configuring layout and wallpaper..."

# $r is a sed command, not a shell variable.
# shellcheck disable=SC2016
sed -i \
    '$r /usr/share/plasma/shells/org.kde.plasma.desktop/contents/updates/bazzite-pins.js' \
    /usr/share/plasma/layout-templates/org.kde.plasma.desktop.defaultPanel/contents/layout.js

ln -sf /usr/share/wallpapers/convergence.jxl /usr/share/backgrounds/default.jxl
ln -sf /usr/share/wallpapers/convergence.jxl /usr/share/backgrounds/default-dark.jxl
rm -f /usr/share/backgrounds/default.xml

mkdir -p /usr/share/wallpapers/bazzite/convergence/contents/images
ln -s /usr/share/wallpapers/convergence.jxl /usr/share/wallpapers/bazzite/convergence/contents/images/3940x2160.jxl
