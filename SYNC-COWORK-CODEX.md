# ⚠️ REGRA DE MANUTENÇÃO — DOIS ALVOS SEMPRE EM SINCRONIA

Este plugin **Yes Corrossel-v1** roda em DUAS plataformas. Toda alteração (editor, SKILL.md,
references, versão) DEVE ser aplicada e publicada nas DUAS.

## Os dois alvos

1. **Claude Cowork** — já funciona e está publicado.
   - Manifesto: `plugins/carrossel-pro/.claude-plugin/plugin.json`
   - Marketplace: `.claude-plugin/marketplace.json` (na raiz do repo)
   - Instala: adicionar marketplace pela URL do repo GitHub no Cowork.

2. **OpenAI Codex** (CLI / IDE / app) — mesmo padrão de skills (agentskills.io).
   - Manifesto: `plugins/carrossel-pro/.codex-plugin/plugin.json`
   - **Catálogo de marketplace (Git):** `.agents/plugins/marketplace.json` na RAIZ do repo (aponta `./plugins/carrossel-pro`). Sem ele o Codex recusa com "marketplace root does not contain a supported manifest".
   - Uso local: copiar `plugins/carrossel-pro/skills/carrossel-pro/` para `~/.codex/skills/yes-corrossel-v1/`.
   - Como plugin: publicar/adicionar o repo via `/plugins` (marketplace Git).

## Fonte única (não duplicar conteúdo)

A MESMA pasta `plugins/carrossel-pro/` serve os dois — ela tem os DOIS manifestos
(`.claude-plugin/` e `.codex-plugin/`) e compartilha:
- `skills/carrossel-pro/SKILL.md`
- `skills/carrossel-pro/references/*`
- `skills/carrossel-pro/assets/carousel-studio.html`  ← o editor (única fonte de verdade)
- `carousel-studio.html` (cópia espelho na raiz do plugin)

## Checklist ao atualizar QUALQUER coisa

1. Edita o editor / SKILL.md / references UMA vez na pasta `plugins/carrossel-pro/`.
2. Garante que `carousel-studio.html` (raiz do plugin) == `skills/carrossel-pro/assets/carousel-studio.html`.
3. Sobe a versão NOS DOIS manifestos: `.claude-plugin/plugin.json` E `.codex-plugin/plugin.json`
   (e em `.claude-plugin/marketplace.json`). Mantenha os números iguais.
4. Commit + push no repo GitHub (vale para Cowork e Codex).
5. Regera os deliverables Codex (zips) se for distribuir fora do GitHub:
   - `yes-corrossel-v1-codex-skill.zip`  (pasta da skill p/ ~/.codex/skills)
   - `yes-corrossel-v1-codex-plugin.zip` (plugin completo c/ .codex-plugin)

## Versão atual: 1.9.2  (editor com IA Gemini, autosave por carrossel, nº gigante em todos os slides)
