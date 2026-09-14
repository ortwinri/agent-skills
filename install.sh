#!/usr/bin/env bash
# Installiert die Skills aus diesem Repo für alle gängigen KI-Tools.
#
#   ./install.sh <projektordner>   Kopie nach <projekt>/.agents/skills + Links für Claude Code und Copilot
#   ./install.sh --user            Links nach ~/.agents/skills und ~/.claude/skills (Updates per git pull)
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
  mkdir -p "$HOME/.agents/skills" "$HOME/.claude/skills"
  for skill in "$SKILLS_DIR"/*/; do
    name="$(basename "$skill")"
    link "$SKILLS_DIR/$name" "$HOME/.agents/skills/$name"
    link "$SKILLS_DIR/$name" "$HOME/.claude/skills/$name"
  done
  exit 0
fi

PROJECT="$(cd "$1" && pwd)" || usage
mkdir -p "$PROJECT/.agents/skills" "$PROJECT/.claude/skills" "$PROJECT/.github/skills"
for skill in "$SKILLS_DIR"/*/; do
  name="$(basename "$skill")"
  rm -rf "$PROJECT/.agents/skills/$name"
  cp -R "$SKILLS_DIR/$name" "$PROJECT/.agents/skills/$name"
  echo "  kopiert:  $PROJECT/.agents/skills/$name"
  # Relative Links, damit sie nach dem Commit bei allen funktionieren.
  link "../../.agents/skills/$name" "$PROJECT/.claude/skills/$name"
  link "../../.agents/skills/$name" "$PROJECT/.github/skills/$name"
done
echo "Fertig. Änderungen im Projekt prüfen und committen."
