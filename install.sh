#!/usr/bin/env bash
# Installiert die Skills aus diesem Repo für alle gängigen KI-Tools.
#
#   ./install.sh <projektordner>   Kopie nach <projekt>/.agents/skills + Links für Claude Code, Copilot, Gemini CLI
#   ./install.sh --user            Links nach ~/.agents, ~/.claude, ~/.gemini (Updates per git pull)
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$REPO_DIR/skills"

usage() {
  sed -n '2,6p' "$0" | sed 's/^# \{0,1\}//'
  exit 1
}

link() { # <ziel> <linkpfad>
  if [ -e "$2" ] && [ ! -L "$2" ]; then
    echo "  übersprungen: $2 existiert bereits (kein Link)"
    return
  fi
  ln -sfn "$1" "$2"
  echo "  verlinkt: $2"
}

[ $# -eq 1 ] || usage

if [ "$1" = "--user" ]; then
  for tool in .agents .claude .gemini; do
    mkdir -p "$HOME/$tool/skills"
    for skill in "$SKILLS_DIR"/*/; do
      name="$(basename "$skill")"
      link "$SKILLS_DIR/$name" "$HOME/$tool/skills/$name"
    done
  done
  exit 0
fi

PROJECT="$(cd "$1" && pwd)" || usage
mkdir -p "$PROJECT/.agents/skills"
for skill in "$SKILLS_DIR"/*/; do
  name="$(basename "$skill")"
  rm -rf "$PROJECT/.agents/skills/$name"
  cp -R "$SKILLS_DIR/$name" "$PROJECT/.agents/skills/$name"
  echo "  kopiert:  $PROJECT/.agents/skills/$name"
  # Relative Links, damit sie nach dem Commit bei allen funktionieren.
  for tool in .claude .github .gemini; do
    mkdir -p "$PROJECT/$tool/skills"
    link "../../.agents/skills/$name" "$PROJECT/$tool/skills/$name"
  done
done
echo "Fertig. Änderungen im Projekt prüfen und committen."
