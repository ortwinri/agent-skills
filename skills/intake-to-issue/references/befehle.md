# Befehle für intake-to-issue

Platzhalter: `<stichwort>`, `<nr>`, `<titel>`, `<typ>`, `<stufe>`.
Den Issue-Body immer in eine temporäre Datei schreiben (z. B. `issue-body.md`)
und per Datei übergeben, nicht inline, damit Umbrüche und Sonderzeichen erhalten bleiben.

## Plattform erkennen

```bash
git remote get-url origin
# github.com/...        → GitHub
# gitlab.com/... o. ä.  → GitLab
```

Ohne Git-Repo: Ziel explizit angeben, `--repo OWNER/REPO` (gh) bzw.
`-R GRUPPE/PROJEKT` (glab).

## GitHub (`gh`)

```bash
gh auth status

# Dedup: offen + geschlossen
gh issue list --state all --search "<stichwort>" --limit 20

# Labels prüfen / fehlende anlegen
gh label list --search "type:"
gh label create "type:<typ>"   --color 1D76DB
gh label create "risk:<stufe>" --color D93F0B

# Issue anlegen
gh issue create --title "<titel>" --body-file issue-body.md \
  --label "type:<typ>,risk:<stufe>"

# Duplikat: am bestehenden Issue kommentieren
gh issue comment <nr> --body "Weitere Meldung: … (Quelle: …)"
```

REST-Fallback (`GITHUB_TOKEN`):

```bash
curl -fsS -H "Authorization: Bearer $GITHUB_TOKEN" \
  "https://api.github.com/search/issues?q=repo:OWNER/REPO+is:issue+<stichwort>"

curl -fsS -X POST -H "Authorization: Bearer $GITHUB_TOKEN" \
  "https://api.github.com/repos/OWNER/REPO/issues" \
  -d '{"title":"<titel>","body":"…","labels":["type:<typ>","risk:<stufe>"]}'
```

## GitLab (`glab`)

```bash
glab auth status

# Dedup: offen + geschlossen
glab issue list --all --search "<stichwort>"

# Labels prüfen / fehlende anlegen
glab label list
glab label create --name "type:<typ>"   --color "#1D76DB"
glab label create --name "risk:<stufe>" --color "#D93F0B"

# Issue anlegen
glab issue create --title "<titel>" --description-file issue-body.md \
  --label "type:<typ>,risk:<stufe>" --yes

# Duplikat: am bestehenden Issue kommentieren
glab issue note <nr> --message "Weitere Meldung: … (Quelle: …)"
```

REST-Fallback (`GITLAB_TOKEN`, Projektpfad URL-kodiert, z. B. `gruppe%2Fprojekt`):

```bash
curl -fsS --header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
  "https://gitlab.com/api/v4/projects/<projekt>/issues?scope=all&search=<stichwort>"

curl -fsS -X POST --header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
  "https://gitlab.com/api/v4/projects/<projekt>/issues" \
  --data-urlencode "title=<titel>" \
  --data-urlencode "description@issue-body.md" \
  --data-urlencode "labels=type:<typ>,risk:<stufe>"
```

Bei selbst gehostetem GitLab `gitlab.com` durch den eigenen Host ersetzen.
