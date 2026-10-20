#!/bin/bash
# Envia e recebe a classificação: guarda os favoritos do MyBar, commita o que
# mudou (wallpapers movidos, temas editados), sincroniza com o GitHub e liga o
# que chegou de outra máquina.
set -euo pipefail
cd "$(dirname "$0")"

STATE="$HOME/.local/state/mybar/state.json"
[[ -f $STATE ]] && jq -r '.favoriteThemes[]?' "$STATE" >favoritos.txt

git add -A
if ! git diff --cached --quiet; then
  n=$(git diff --cached --name-only | wc -l)
  git commit -q -m "Classificação atualizada em $(hostname) ($n arquivos)" \
    -m "$(git diff --cached --name-status -M | sed 's/^/  /')"
fi
git pull --rebase -q
git push -q
git log --oneline -3

./install.sh >/dev/null
echo "Sincronizado."
