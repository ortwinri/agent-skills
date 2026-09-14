# Agent Skills

Team-Skills im offenen [Agent-Skills-Format](https://agentskills.io): ein Ordner
mit `SKILL.md`, den Claude Code, OpenAI Codex, GitHub Copilot, Cursor, Gemini CLI
und andere Tools lesen können. Egal welches KI-Tool du nutzt, der Skill ist derselbe.

| Skill | Wofür |
|-------|-------|
| [intake-to-issue](skills/intake-to-issue/SKILL.md) | Mail, Ticket oder Chat-Nachricht → dedupliziertes Issue auf GitHub oder GitLab, mit Typ- und Risiko-Label |

## Voraussetzungen

- Zugriff auf dieses Repo (privat, Einladung nötig)
- Für Issues: `gh` (GitHub) bzw. `glab` (GitLab), angemeldet per `gh auth login` / `glab auth login`

## Installation

Repo einmal klonen:

```bash
git clone https://github.com/ortwinri/agent-skills.git
```

### Variante A: für dich persönlich, in allen Projekten

```bash
./agent-skills/install.sh --user
```

Legt Links in `~/.agents/skills/` und `~/.claude/skills/` an. Updates holst du mit
`git pull` im geklonten Repo.

### Variante B: im Projekt-Repo, fürs ganze Team

```bash
./agent-skills/install.sh ~/pfad/zum/projekt
```

Kopiert die Skills nach `.agents/skills/` und legt relative Links in
`.claude/skills/` und `.github/skills/` an. Danach im Projekt committen, dann hat
jeder den Skill, der das Projekt klont.

### Variante C: Claude Code als Plugin

```
/plugin marketplace add ortwinri/agent-skills
/plugin install agent-skills@agent-skills
```

## Wo die Tools Skills suchen

| Tool | Projekt | Persönlich |
|------|---------|------------|
| Claude Code | `.claude/skills/` | `~/.claude/skills/` |
| OpenAI Codex | `.agents/skills/` | `~/.agents/skills/` |
| GitHub Copilot (VS Code, CLI) | `.github/skills/`, `.claude/skills/` | `~/.copilot/skills/`, `~/.claude/skills/` |
| Cursor | `.cursor/skills/`, `.claude/skills/` | `~/.cursor/skills/` |
| Gemini CLI | `.gemini/skills/`, `.agents/skills/` | `~/.gemini/skills/` |

Die Pfade ändern sich gelegentlich. Wird ein Skill nicht gefunden, in der Doku
des Tools nachsehen und ggf. einen weiteren Link anlegen.

**Claude.ai / Claude Desktop (Chat):** Ordner `skills/intake-to-issue` als ZIP
packen und unter *Einstellungen → Fähigkeiten → Skills* hochladen.

**Tools ohne Skill-Unterstützung** (z. B. ChatGPT im Browser, M365 Copilot):
Inhalt von `SKILL.md` als eigene Anweisungen, Custom GPT oder Gem hinterlegen.
Ausführen müssen die Befehle dann ggf. die Nutzenden selbst.

Im Projekt hilft zusätzlich eine Zeile in `AGENTS.md`:

```markdown
Für neue Anliegen, Bugs oder Feature-Wünsche `.agents/skills/intake-to-issue/SKILL.md` befolgen.
```

## Einen Skill ändern oder hinzufügen

- Ein Ordner pro Skill unter `skills/<name>/`, der Ordnername entspricht `name` im Frontmatter.
- `SKILL.md` kurz halten, Details in `references/`, Vorlagen in `assets/`.
- Keine tool-spezifischen Pfade oder Variablen (z. B. `${CLAUDE_PLUGIN_ROOT}`) verwenden.
- Änderungen per Pull Request.
