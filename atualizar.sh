#!/usr/bin/env bash
# Sobe a versao do plugin carrossel-pro e publica no GitHub.
# Uso:
#   ./atualizar.sh            -> sobe o patch (1.6.0 -> 1.6.1)
#   ./atualizar.sh minor      -> sobe o minor (1.6.0 -> 1.7.0)
#   ./atualizar.sh major      -> sobe o major (1.6.0 -> 2.0.0)
#   ./atualizar.sh 2.3.1      -> define a versao exata
set -euo pipefail
cd "$(dirname "$0")"

PLUGIN_JSON="plugins/carrossel-pro/.claude-plugin/plugin.json"
MARKET_JSON=".claude-plugin/marketplace.json"

[ -f "$PLUGIN_JSON" ] || { echo "ERRO: rode o script na raiz do repositorio (nao achei $PLUGIN_JSON)."; exit 1; }
command -v git >/dev/null || { echo "ERRO: git nao encontrado. Instale o git."; exit 1; }
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || { echo "ERRO: esta pasta nao e um repositorio git. Rode 'git init' e configure o remote primeiro."; exit 1; }

# versao atual (do plugin.json)
CUR=$(grep -oE '"version"[[:space:]]*:[[:space:]]*"[0-9]+\.[0-9]+\.[0-9]+"' "$PLUGIN_JSON" | head -1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' || true)
[ -n "$CUR" ] || { echo "ERRO: nao consegui ler a versao atual em $PLUGIN_JSON"; exit 1; }
IFS='.' read -r MA MI PA <<< "$CUR"

ARG="${1:-patch}"
NEW=""
case "$ARG" in
  patch) PA=$((PA+1)) ;;
  minor) MI=$((MI+1)); PA=0 ;;
  major) MA=$((MA+1)); MI=0; PA=0 ;;
  [0-9]*.[0-9]*.[0-9]*) NEW="$ARG" ;;
  *) echo "Uso: ./atualizar.sh [patch|minor|major|X.Y.Z]"; exit 1 ;;
esac
NEW="${NEW:-$MA.$MI.$PA}"

echo "Versao: $CUR  ->  $NEW"

# substitui "version": "CUR" por "version": "NEW" nos dois arquivos
for F in "$PLUGIN_JSON" "$MARKET_JSON"; do
  if grep -q "\"version\"[[:space:]]*:[[:space:]]*\"$CUR\"" "$F"; then
    sed -i.bak "s/\"version\"[[:space:]]*:[[:space:]]*\"$CUR\"/\"version\": \"$NEW\"/" "$F"
    rm -f "$F.bak"
    echo "  atualizado: $F"
  else
    echo "  AVISO: nao achei a versao $CUR em $F (pulado)"
  fi
done

# valida os JSONs se houver python
if command -v python3 >/dev/null; then
  python3 -c "import json;json.load(open('$PLUGIN_JSON'));json.load(open('$MARKET_JSON'));print('  JSON valido')"
fi

# commit + push
git add -A
if git diff --cached --quiet; then
  echo "Nada pra commitar."; exit 0
fi
git commit -m "carrossel-pro v$NEW"
echo "Enviando pro GitHub..."
git push
echo ""
echo "OK! Publicado v$NEW."
echo "Quem ja instalou recebe atualizando o marketplace:"
echo "  - Cowork: botao de atualizar/refresh nas configuracoes de plugins"
echo "  - Claude Code: /plugin marketplace update"
