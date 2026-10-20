#!/bin/bash
# Liga este repositório ao Omarchy. O repositório É ~/.config/omarchy/backgrounds
# (sem link no caminho, para o "próximo wallpaper" do Omarchy reconhecer o fundo
# atual); cada tema de themes/ vira um link em ~/.config/omarchy/themes e
# favoritos.txt vai para o MyBar. Pode rodar várias vezes.
set -euo pipefail

REPO=$(cd "$(dirname "$0")" && pwd -P)
BG="$HOME/.config/omarchy/backgrounds"
THEMES="$HOME/.config/omarchy/themes"
STATE="$HOME/.local/state/mybar/state.json"
BACKUP="$HOME/.local/state/wallpapers-backup/$(date +%F-%H%M%S)"

say() { printf '\033[1;36m==>\033[0m %s\n' "$*"; }

if [[ $REPO != "$(cd "$BG" 2>/dev/null && pwd -P)" ]]; then
  echo "Este repositório precisa estar em ~/.config/omarchy/backgrounds:" >&2
  echo "  mv ~/.config/omarchy/backgrounds ~/.config/omarchy/backgrounds.antes   # se existir" >&2
  echo "  git clone https://github.com/viniciusapl97/wallpapers ~/.config/omarchy/backgrounds" >&2
  exit 1
fi

mkdir -p "$THEMES" "$HOME/Imagens/wallpaper-1210"

# Wallpapers que a máquina tinha antes do clone entram no repositório.
if [[ -d $BG.antes ]]; then
  say "Juntando ~/.config/omarchy/backgrounds.antes"
  cp -r --update=none -- "$BG.antes/." "$REPO/"
  echo "  pode apagar backgrounds.antes depois de conferir"
fi

say "Temas"
for t in "$REPO"/themes/*/; do
  t=${t%/}; dest="$THEMES/$(basename "$t")"
  [[ -L $dest && $(readlink "$dest") == "$t" ]] && continue
  if [[ -e $dest || -L $dest ]]; then
    mkdir -p "$BACKUP"; mv -- "$dest" "$BACKUP/"
    echo "  backup: ${dest/#$HOME/\~} -> ${BACKUP/#$HOME/\~}"
  fi
  ln -s -- "$t" "$dest"
  echo "  $(basename "$t")"
done

say "Favoritos do MyBar"
favs=$(jq -R . "$REPO/favoritos.txt" | jq -sc 'map(select(length > 0))')
mkdir -p "$(dirname "$STATE")"
if [[ -s $STATE ]]; then
  # O MyBar observa o arquivo: reescreve no lugar para manter o mesmo inode.
  new=$(jq --argjson f "$favs" '.favoriteThemes = $f' "$STATE")
  cat >"$STATE" <<<"$new"
else
  jq -n --argjson f "$favs" '{favoriteThemes: $f}' >"$STATE"
fi
echo "  $(jq length <<<"$favs") temas"

say "Pronto: $(find "$REPO" -mindepth 2 -maxdepth 2 -type f -path "$REPO/[!.]*" ! -path "$REPO/outros/*" ! -path "$REPO/themes/*" | wc -l) wallpapers classificados. Para aplicar um tema: omarchy-theme-set <tema>"
