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

Legt Links in `~/.agents/skills/`, `~/.claude/skills/` und `~/.gemini/skills/` an.
Updates holst du mit `git pull` im geklonten Repo.

### Variante B: im Projekt-Repo, fürs ganze Team

```bash
./agent-skills/install.sh ~/pfad/zum/projekt
```

Kopiert die Skills nach `.agents/skills/` und legt relative Links in
`.claude/skills/`, `.github/skills/` und `.gemini/skills/` an. Danach im Projekt committen, dann hat
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

Im Projekt hilft zusätzlich eine Zeile in `AGENTS.md` (Gemini CLI: `GEMINI.md`):

```markdown
Für neue Anliegen, Bugs oder Feature-Wünsche `.agents/skills/intake-to-issue/SKILL.md` befolgen.
```

## Chat-Tools ohne Zugriff auf Repo und Terminal

Gemini, ChatGPT, M365 Copilot usw. im Browser können keine Befehle ausführen.
Dafür gibt es [chat/intake-to-issue.md](chat/intake-to-issue.md): Der Assistent
bereitet Titel, Beschreibung, Labels und Suchlinks für die Duplikatprüfung vor,
angelegt wird das Issue von Hand.

1. Inhalt der Datei kopieren und oben die URL des Ziel-Repos eintragen.
2. Als feste Anweisung hinterlegen:
   - **Gemini:** neues Gem anlegen, Text unter *Anweisungen* einfügen
   - **ChatGPT:** eigenes GPT oder Projekt mit diesen Anweisungen
   - **Claude.ai:** Projekt anlegen, Text als Projekt-Anweisungen
   - **Sonst:** Text am Anfang des Chats einfügen
3. Anliegen hineinkopieren.

**Datenschutz:** Bei kostenlosen Versionen können Chats zum Training genutzt und
von Menschen gelesen werden. Support-Mails vor dem Einfügen anonymisieren oder die
Speicherung der Aktivitäten im Tool ausschalten.

Wer `SKILL.md` ändert, passt die Chat-Fassung mit an.

## Einen Skill ändern oder hinzufügen

- Ein Ordner pro Skill unter `skills/<name>/`, der Ordnername entspricht `name` im Frontmatter.
- `SKILL.md` kurz halten, Details in `references/`, Vorlagen in `assets/`.
- Keine tool-spezifischen Pfade oder Variablen (z. B. `${CLAUDE_PLUGIN_ROOT}`) verwenden.
- Änderungen per Pull Request.
