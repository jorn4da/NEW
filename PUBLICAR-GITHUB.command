#!/usr/bin/env bash
# ============================================================
#  PUBLICAR a Landing Page NOVA LEOPOLDINA no GitHub
#  Repositório: https://github.com/jorn4da/NEW
#
#  O que este script faz, em ordem:
#    1) Prepara a pasta como repositório Git (só na 1ª vez).
#    2) Ignora arquivos pesados/desnecessários (vídeos originais, .DS_Store).
#    3) Faz commit de tudo e envia (push) para o GitHub.
#
#  Basta dar DOIS CLIQUES neste arquivo.
#  (Se pedir usuário/senha do GitHub, use seu token de acesso.)
# ============================================================
set -e

# Pasta onde este script está (a própria LP)
DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_URL="https://github.com/jorn4da/NEW.git"

cd "$DIR"

echo "=================================================="
echo "  PUBLICAR: Nova Leopoldina  ->  jorn4da/NEW"
echo "  Pasta: $DIR"
echo "=================================================="
read -r -p "Enter para publicar (ou feche a janela para cancelar)... " _

# 1) Arquivos a ignorar (não vão para o GitHub)
cat > .gitignore <<'EOF'
.DS_Store
# Vídeos originais pesados (a página usa apenas as versões -web)
assets/video/hero-nova-leopoldina.mp4
assets/video/piscina.mp4
EOF

# GitHub Pages: não processar com Jekyll (mantém pastas intactas)
touch .nojekyll

# 2) Inicializa o repositório na 1ª vez
if [ ! -d ".git" ]; then
  echo "→ Primeira publicação: preparando o repositório..."
  git init
  git branch -M main
  git remote add origin "$REPO_URL"
else
  # garante que o remoto está correto
  git remote set-url origin "$REPO_URL" 2>/dev/null || git remote add origin "$REPO_URL"
  git branch -M main 2>/dev/null || true
fi

# 3) Commit com data e hora
git add -A
if git diff --cached --quiet; then
  echo "→ Nada novo para publicar (nenhuma alteração)."
else
  git commit -m "Atualiza Landing Page Nova Leopoldina — $(date '+%d/%m/%Y %H:%M')"
fi

# 4) Envia para o GitHub
echo "→ Enviando para o GitHub..."
if ! git push -u origin main 2>/dev/null; then
  echo "→ O repositório já tinha conteúdo. Sincronizando..."
  git pull origin main --rebase --allow-unrelated-histories || true
  git push -u origin main
fi

echo ""
echo "✅ Publicado com sucesso em: https://github.com/jorn4da/NEW"
echo ""
echo "   Para ativar o site (GitHub Pages):"
echo "   Settings > Pages > Branch: main / (root) > Save"
echo "   O site ficará em: https://jorn4da.github.io/NEW/"
echo ""
read -r -p "Pode fechar esta janela. (Enter) " _
