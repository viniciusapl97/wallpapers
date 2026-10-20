# wallpapers

Meus wallpapers do Omarchy já separados por tema, e os temas que criei ou
ajustei para eles. O repositório é a própria `~/.config/omarchy/backgrounds`.

```
<tema>/          wallpapers de cada tema
themes/<tema>/   temas próprios e ajustados (viram ~/.config/omarchy/themes/<tema>)
favoritos.txt    temas favoritos do MyBar: os que têm wallpaper meu
outros/          wallpapers antigos que não estão em nenhum tema
```

## Numa máquina nova

```bash
mv ~/.config/omarchy/backgrounds ~/.config/omarchy/backgrounds.antes 2>/dev/null
git clone https://github.com/viniciusapl97/wallpapers ~/.config/omarchy/backgrounds
~/.config/omarchy/backgrounds/install.sh
```

O `install.sh` liga os temas de `themes/` em `~/.config/omarchy/themes`, grava
os favoritos no MyBar e junta ao repositório o que estava em
`backgrounds.antes`. Pode rodar de novo quando quiser.

## No dia a dia

Classifique pelo Wallpaper organizer
([viniciusapl97/wallpaper-organizer](https://github.com/viniciusapl97/wallpaper-organizer));
o que ele move já está no repositório. Depois:

```bash
~/.config/omarchy/backgrounds/sync.sh
```

Ele guarda os favoritos do MyBar em `favoritos.txt`, commita, faz pull e push e
liga temas novos que vieram da outra máquina.

## Critério

Cada tema mantém a identidade dos wallpapers de fábrica: a mesma paleta e o
mesmo estilo (tokyo-night é synthwave magenta, solitude é monocromático
granulado, nord e catppuccin seguem as paletas da comunidade). Wallpaper que
não combina com nenhum ganha um tema com as cores dele.

## Temas

| Tema | O que é |
|---|---|
| `natsuzora` | noite de verão: azul-marinho com céu claro, para os wallpapers de verão e céu aberto |
| `minamo` | aqua/teal escuro com coral, para os wallpapers aquáticos |
| `crimson-gold` | [knappkevin/omarchy-crimson-gold-theme](https://github.com/knappkevin/omarchy-crimson-gold-theme) com as cores suavizadas para sessões longas |
| `last-horizon`, `solitude`, `flexoki-light` | cópias dos temas do Omarchy com ajustes de contraste (o motivo está no topo de cada `colors.toml`) |

Para voltar um tema ajustado ao de fábrica, apague o link
`~/.config/omarchy/themes/<tema>` e a pasta `themes/<tema>`.
