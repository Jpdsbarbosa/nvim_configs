# 🚀 Minha Configuração do Neovim

Uma configuração moderna e otimizada do Neovim focada em produtividade e desenvolvimento.

## ✨ Features

- 🎨 Interface moderna com temas customizados
- 📁 Explorador de arquivos integrado
- 🔍 Busca fuzzy ultra-rápida
- 💡 Autocompletion inteligente
- 🛠️ LSP integrado para múltiplas linguagens
- 🌳 Git integration
- 🎯 Navegação rápida entre arquivos
- 🔧 Configuração modular e organizada

## 📋 Pré-requisitos

Antes de instalar, certifique-se de ter:

- **Neovim** >= 0.9.0
- **Git**
- **Node.js** >= 16.0
- **Python 3** com pip
- **Ripgrep** (para busca)
- **fd** (para navegação de arquivos)

### Instalação das dependências (Ubuntu/Debian):
```bash
sudo apt update
sudo apt install neovim git nodejs npm python3 python3-pip ripgrep fd-find
```

### Instalação das dependências (macOS):
```bash
brew install neovim git node python ripgrep fd
```

## 🚀 Instalação

### 1. Backup da configuração atual (se existir)
```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.cache/nvim ~/.cache/nvim.backup
```

### 2. Clonar o repositório
```bash
git clone https://github.com/Jpdsbarbosa/nvim_configs.git ~/.config/nvim
```

### 3. Instalar plugins
```bash
nvim +PackerInstall +qa
```

### 4. Primeiro uso
Abra o Neovim:
```bash
nvim
```

Se alguns plugins não carregarem, execute:
```bash
:PackerSync
```

## 🎮 Principais Keymaps

### Navegação
- `<Space>` - Leader key
- `<leader>ff` - Buscar arquivos
- `<leader>fg` - Buscar texto
- `<leader>fb` - Buscar buffers
- `<leader>e` - Toggle file explorer
- `<C-h/j/k/l>` - Navegar entre splits

### Edição
- `<leader>w` - Salvar arquivo
- `<leader>q` - Fechar buffer
- `<leader>/` - Comentar/descomentar linha
- `<leader>ca` - Code actions
- `gd` - Ir para definição
- `gr` - Listar referências

### Git
- `<leader>gs` - Git status
- `<leader>gc` - Git commit
- `<leader>gp` - Git push
- `<leader>gl` - Git log

## 🔧 Estrutura da Configuração

```
~/.config/nvim/
├── init.lua                 # Ponto de entrada principal
├── settings.vim             # Configurações gerais do Vim
├── lua/                     # Configurações Lua
├── plug-config/             # Configurações dos plugins
├── plugin/                  # Plugins carregados
├── packer.nvim/             # Gerenciador Packer
├── autoload/                # Scripts de autoload
├── vim-plug/                # Gerenciador vim-plug
└── README.md
```

## 📦 Plugins Principais

- **[packer.nvim](https://github.com/wbthomason/packer.nvim)** - Gerenciador de plugins
- **[vim-plug](https://github.com/junegunn/vim-plug)** - Gerenciador alternativo de plugins
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Busca fuzzy
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Syntax highlighting
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - Gerenciador de LSP
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - Configuração LSP
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - Autocompletion
- **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** - Git integration
- **[nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)** - File explorer

## 🎨 Temas Incluídos

- Catppuccin
- Gruvbox
- Dracula
- Nord
- Tokyonight

Para trocar o tema, edite o arquivo `lua/core/options.lua`:
```lua
vim.cmd.colorscheme('catppuccin')
```

## 🛠️ Customização

### Adicionar novos plugins

**Com Packer** (edite o arquivo com suas configurações do Packer):
```lua
use {
  'autor/nome-do-plugin',
  config = function()
    -- configuração do plugin
  end
}
```

**Com vim-plug** (edite o arquivo de configuração):
```vim
Plug 'autor/nome-do-plugin'
```

Depois execute:
```bash
:PackerSync  # Para Packer
# ou
:PlugInstall # Para vim-plug
```

### Modificar keymaps
Edite o arquivo `settings.vim` ou arquivos na pasta `lua/`:
```lua
vim.keymap.set('n', '<leader>sua-tecla', '<comando>', { desc = 'Descrição' })
```

## 🐛 Troubleshooting

### Plugins não carregam
```bash
:PackerSync
# ou
:PlugInstall
:PlugUpdate
```

### LSP não funciona
```bash
:checkhealth mason
:checkhealth lsp
```

### Performance lenta
```bash
:checkhealth
```

## 🤝 Contribuindo

Sinta-se à vontade para:
- Abrir issues
- Fazer fork e melhorar
- Sugerir novos plugins
- Reportar bugs

## 📝 Licença

MIT License - use como quiser!

## 🙏 Agradecimentos

Inspirado por várias configurações incríveis da comunidade Neovim.

---

**Desenvolvido com ❤️ por [Jpdsbarbosa](https://github.com/Jpdsbarbosa)**

*"Vim é um editor que cresce com você!"*

<img width="1899" height="1006" alt="image" src="https://github.com/user-attachments/assets/47ee0b91-b119-4035-b358-fd113ca3ac24" />
<img width="1892" height="1012" alt="image" src="https://github.com/user-attachments/assets/6b28d892-310a-48d9-8949-e0ba7dc76d48" />

