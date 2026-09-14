---
name: intake-to-issue
description: Wandelt eine rohe Anfrage, Mail, Chat-Nachricht oder ein Support-Ticket in ein typisiertes, dedupliziertes Issue auf GitHub oder GitLab um, mit Risiko-Vorklassifikation und Labels. Trigger-Phrasen sind Anliegen aufnehmen, Ticket anlegen, Issue erstellen, Bug oder Feature melden, Intake.
---

# intake-to-issue

Macht aus einem unstrukturierten Anliegen ein sauberes, auffindbares Issue.
Erster Schritt der Lieferkette: danach folgt das Refinement.

## Voraussetzungen

- Das Arbeitsverzeichnis ist ein Git-Repo, oder der Nutzer nennt das Ziel-Repo.
- Zugriff auf die Plattform, in dieser Reihenfolge:
  1. GitHub- bzw. GitLab-Tools des eigenen KI-Tools (MCP), falls verfügbar
  2. `gh` bzw. `glab` CLI (angemeldet)
  3. REST-API mit `GITHUB_TOKEN` bzw. `GITLAB_TOKEN`
- Konkrete Befehle: [references/befehle.md](references/befehle.md)

## Ablauf

1. **Plattform bestimmen:** `git remote get-url origin` auswerten
   (`github.com` → GitHub, sonst `gitlab` im Host → GitLab). Unklar ⇒ nachfragen.
2. **Anliegen erfassen:** Quelle zusammenfassen: Problem, erwartetes Verhalten,
   betroffener Bereich, Dringlichkeit, Quelle (Mail, Ticket, Chat).
   Fehlt Wesentliches (z. B. Repro-Schritte bei einem Bug), gezielt nachfragen.
3. **Typ bestimmen:** `bug` | `feature` | `task` | `question`.
4. **Deduplizieren:** offene **und** geschlossene Issues nach 2–3
   Schlüsselbegriffen durchsuchen. Passender Treffer ⇒ **kein** neues Issue,
   stattdessen am bestehenden kommentieren und dessen Link zurückmelden.
5. **Risiko vorklassifizieren:** grob nach Tragweite, wird im Refinement bestätigt.
   - `low`: lokal begrenzt, kein Datenmodell, keine Sicherheit
   - `med`: mehrere Stellen oder geteilte Logik betroffen
   - `high`: Datenmodell/Migration, Auth, Zahlungen, Datenschutz, Produktionsdaten
6. **Entwurf zeigen:** Titel, Body (Vorlage: [assets/issue-body.md](assets/issue-body.md)),
   Labels. Anlegen erst nach Bestätigung, außer der Nutzer hat ausdrücklich
   „direkt anlegen" gesagt.
7. **Issue anlegen:** Labels `type:<typ>` und `risk:<stufe>`. Existiert ein Label
   im Repo nicht, anlegen, falls die Rechte reichen; sonst ohne Label anlegen und
   das dem Nutzer melden.
8. **Rückverknüpfung:** stammt das Anliegen aus einem externen Ticket, beide
   Seiten verlinken (bzw. dem Nutzer den Link für das Ticket geben).

## Output

Issue-Nummer, URL, Typ und Risiko. Bei Duplikat: Link zum bestehenden Issue.

## Leitplanken

- Keine Duplikate anlegen.
- Keine Secrets oder personenbezogenen Daten aus der Quelle übernehmen:
  Tokens, Passwörter, E-Mail-Adressen, Telefonnummern, Namen von Betroffenen
  neutralisieren (z. B. „ein Nutzer meldet …").
- Issues mit Label `manual` nie automatisch weiterverarbeiten.
- Titel kurz und sachlich, im Body nur, was für das Verständnis nötig ist.

## Beispiel-Prompts

- „Nimm diese Support-Mail auf und leg ein Issue an."
- „Mach aus diesem Bug-Report ein Issue mit Repro-Schritten."
