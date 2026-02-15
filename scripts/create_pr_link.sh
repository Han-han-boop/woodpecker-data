#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: scripts/create_pr_link.sh [base_branch]

Pushes the current branch to origin and prints the GitHub compare URL.
Default base branch: main
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

BASE_BRANCH="${1:-main}"
CURRENT_BRANCH="$(git branch --show-current)"

if [[ -z "$CURRENT_BRANCH" ]]; then
  echo "Erreur: impossible de détecter la branche courante." >&2
  exit 1
fi

if [[ "$CURRENT_BRANCH" == "$BASE_BRANCH" ]]; then
  echo "Erreur: vous êtes sur '$BASE_BRANCH'. Placez-vous sur une branche de travail (ex: work)." >&2
  exit 1
fi

if ! git remote get-url origin >/dev/null 2>&1; then
  echo "Erreur: remote 'origin' introuvable." >&2
  echo "Ajoutez-le puis relancez: git remote add origin <url-du-repo>" >&2
  exit 1
fi

ORIGIN_URL="$(git remote get-url origin)"

if [[ "$ORIGIN_URL" =~ ^git@github.com:(.+)/(.+)\.git$ ]]; then
  OWNER="${BASH_REMATCH[1]}"
  REPO="${BASH_REMATCH[2]}"
elif [[ "$ORIGIN_URL" =~ ^https://github.com/(.+)/(.+)\.git$ ]]; then
  OWNER="${BASH_REMATCH[1]}"
  REPO="${BASH_REMATCH[2]}"
else
  echo "Erreur: remote origin non-GitHub ou format non supporté: $ORIGIN_URL" >&2
  exit 1
fi

echo "Push de la branche '$CURRENT_BRANCH' vers origin..."
git push -u origin "$CURRENT_BRANCH"

echo
echo "✅ Ouvrez ce lien pour créer la PR :"
echo "https://github.com/$OWNER/$REPO/compare/$BASE_BRANCH...$CURRENT_BRANCH"
