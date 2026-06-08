# Carrossel Pro — Marketplace

Marketplace de plugin pro **Claude Cowork / Claude Code** que distribui o plugin **carrossel-pro** (habilidade de carrosseis + editor visual Carousel Studio) com **atualizacao automatica** via GitHub.

---

## 1. Publicar no GitHub (uma vez)

Pre-requisitos: ter o `git` instalado e uma conta no GitHub.

1. Crie um repositorio novo no GitHub chamado `carrossel-pro-marketplace` (pode ser **publico**).
2. No seu computador, dentro desta pasta, rode:

```bash
git init
git add .
git commit -m "carrossel-pro marketplace v1.6.0"
git branch -M main
git remote add origin https://github.com/SEU-USUARIO/carrossel-pro-marketplace.git
git push -u origin main
```

Troque `SEU-USUARIO` pelo seu usuario do GitHub. Pronto - o marketplace esta no ar.

> Dica: edite tambem o campo `homepage` em `.claude-plugin/marketplace.json` trocando `SEU-USUARIO`.

---

## 2. Como outra pessoa instala

### No Claude Cowork (app desktop)
1. Va em **Configuracoes -> Plugins** (ou no marketplace de plugins do Cowork).
2. **Add plugin / Adicionar marketplace** -> fonte **GitHub** -> informe `SEU-USUARIO/carrossel-pro-marketplace`.
3. Instale o plugin **carrossel-pro** no catalogo.

### No Claude Code (terminal)
```bash
/plugin marketplace add SEU-USUARIO/carrossel-pro-marketplace
/plugin install carrossel-pro@carrossel-pro-marketplace
```

Depois de instalar, e so pedir: **"cria um carrossel sobre X"** - a habilidade conduz tudo e entrega o `carrossel-editor.html` ja preenchido, pronto pra ajustar e exportar os PNGs em ZIP.

---

## 3. Atualizacao automatica

Sempre que voce melhorar o plugin:

1. Edite os arquivos em `plugins/carrossel-pro/` (ex.: o `carousel-studio.html` ou a `SKILL.md`).
2. **Suba a versao** em dois lugares (use o mesmo numero):
   - `plugins/carrossel-pro/.claude-plugin/plugin.json` -> campo `version`
   - `.claude-plugin/marketplace.json` -> `version` do plugin
3. Faca commit e push **automaticamente** com o script incluido:

```bash
./atualizar.sh          # sobe o patch (1.6.0 -> 1.6.1) e da push
./atualizar.sh minor    # 1.6.0 -> 1.7.0
./atualizar.sh 2.0.0    # define a versao exata
```

O script atualiza a versao nos dois arquivos, faz commit e push sozinho.
(No Windows, rode pelo Git Bash. Se precisar: `chmod +x atualizar.sh`.)

Quem ja instalou recebe a atualizacao ao **atualizar o marketplace**:
- **Cowork:** botao de atualizar/refresh do marketplace nas configuracoes de plugins.
- **Claude Code:** `/plugin marketplace update`

Em planos **Team/Enterprise**, o owner pode definir o plugin como **auto-instalavel** pra toda a organizacao (Admin -> Plugins), e ai ele e adicionado e atualizado automaticamente pra todos.

---

## Estrutura do repositorio

```
carrossel-pro-marketplace/
├── .claude-plugin/
│   └── marketplace.json          # catalogo (lista os plugins)
├── plugins/
│   └── carrossel-pro/            # o plugin (habilidade + editor)
│       ├── .claude-plugin/plugin.json
│       ├── carousel-studio.html  # editor visual
│       ├── README.md
│       └── skills/carrossel-pro/ # SKILL.md + referencias + kits
└── README.md                     # este guia
```

## Licenca

MIT.
