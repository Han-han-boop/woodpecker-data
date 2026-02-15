# woodpecker-data

Dépôt de stockage de données de marché (OHLC) pour l'or, organisé par timeframe et par sessions.

## Structure

- `gold/h4/`
  - Données H4 historiques.
- `gold/session/<session_id>/m1/`
  - Données M1 pour une session donnée.
- `gold/session/<session_id>/m15/`
  - Données M15 pour une session donnée.

## Convention de sessions

Les sessions sont pré-créées de `001` à `102`.

Exemples de chemins attendus :

- `gold/session/001/m1/2025-09-11_m1.csv`
- `gold/session/001/m15/2025-09-11_m15.csv`

Les dossiers vides contiennent un fichier `.gitkeep` pour conserver l'arborescence dans Git.

## Solution efficace pour créer la PR

Depuis votre clone local (là où `origin` est configuré), lancez :

```bash
scripts/create_pr_link.sh
```

Le script :

1. vérifie que vous n'êtes pas sur `main`,
2. pousse la branche courante sur `origin`,
3. affiche le lien exact `main...<branche>` à ouvrir pour créer la PR.
