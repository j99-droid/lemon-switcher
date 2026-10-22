#!/usr/bin/env bash
# Installs claude-switch + Lemon Switcher for this user and adds it to the app menu.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
bin="$HOME/.local/bin"
apps="$HOME/.local/share/applications"
icons="$HOME/.local/share/icons/hicolor/scalable/apps"

mkdir -p "$bin" "$apps" "$icons"
install -m 755 "$here/claude-switch" "$bin/claude-switch"
install -m 755 "$here/lemon-switcher" "$bin/lemon-switcher"

# App icon: the happy lemon from the window itself.
python3 - "$bin/lemon-switcher" "$icons/lemon-switcher.svg" <<'EOF'
import sys
from importlib.machinery import SourceFileLoader
m = SourceFileLoader("ls", sys.argv[1]).load_module()
open(sys.argv[2], "w").write(m.lemon_svg("active"))
EOF

cat > "$apps/lemon-switcher.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Lemon Switcher
Comment=Switch whose Claude account this computer and OpenClaw use
Exec=$bin/lemon-switcher
Icon=lemon-switcher
Terminal=false
Categories=Utility;
EOF

echo "Installed. Open 'Lemon Switcher' from your app menu, or run: lemon-switcher"
