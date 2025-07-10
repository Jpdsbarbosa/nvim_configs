-- Desabilitar netrw (recomendado para evitar conflito com nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' '  -- Define espaço como leader

-- Ativar true colors (24-bit) para temas e ícones
vim.opt.termguicolors = true

-- Configurações básicas do editor
vim.opt.number = true          -- Números de linha
vim.opt.relativenumber = true  -- Números relativos
vim.opt.cursorline = true      -- Destacar linha atual
vim.opt.wrap = false           -- Não quebrar linhas
vim.opt.scrolloff = 8          -- Manter 8 linhas visíveis ao rolar

-- Indentação
vim.opt.tabstop = 4        -- Tamanho do tab
vim.opt.shiftwidth = 4     -- Tamanho da indentação
vim.opt.expandtab = true   -- Converter tabs em espaços
vim.opt.autoindent = true  -- Auto-indentação

-- Busca
vim.opt.ignorecase = true  -- Ignorar maiúsculas/minúsculas
vim.opt.smartcase = true   -- Mas ser case-sensitive se tiver maiúscula
vim.opt.hlsearch = true    -- Destacar resultados da busca

-- Configurações de diagnóstico para erros em tempo real
vim.opt.updatetime = 300  -- Tempo para atualizar diagnósticos (300ms)
vim.opt.signcolumn = "yes"  -- Sempre mostrar coluna de sinais

-- ========== CONFIGURAÇÕES PARA NAVEGAÇÃO MELHORADA ==========
-- Permitir que setas e h/l naveguem entre linhas
vim.opt.whichwrap:append "<,>,[,],h,l"

-- Configurar backspace para comportamento mais natural
vim.opt.backspace = { 'indent', 'eol', 'start' }

-- Plugin manager: packer
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'         -- Packer gerenciador de plugins
  use 'neovim/nvim-lspconfig'          -- Configuração LSP
  use 'hrsh7th/nvim-cmp'               -- Autocomplete
  use 'hrsh7th/cmp-nvim-lsp'           -- Fonte LSP para nvim-cmp
  use 'hrsh7th/cmp-buffer'             -- Buffer source
  use 'hrsh7th/cmp-path'               -- Path source
  use 'hrsh7th/cmp-cmdline'            -- Cmdline source
  use 'hrsh7th/vim-vsnip'              -- Snippet engine
  use 'hrsh7th/cmp-vsnip'              -- Snippet completions
  use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } } -- fuzzy finder
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  -- nvim-tree com dependência nvim-web-devicons para os ícones
  use {
    'nvim-tree/nvim-tree.lua',
    requires = 'nvim-tree/nvim-web-devicons',
  }
  use 'nvim-tree/nvim-web-devicons' -- garante que o plugin de ícones esteja instalado
  -- Tema, barra de status, terminal flutuante
  use 'folke/tokyonight.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'akinsho/toggleterm.nvim'
  -- Plugin para auto-pareamento de parênteses, chaves, etc.
  use 'windwp/nvim-autopairs'
  -- Plugin para melhor visualização de diagnósticos
  use 'folke/trouble.nvim'  -- Lista de erros/warnings
end)

-- Configuração de diagnósticos
vim.diagnostic.config({
  virtual_text = {
    enabled = true,
    source = "if_many",
    prefix = "●",
  },
  signs = true,
  underline = true,
  update_in_insert = true,  -- Atualizar diagnósticos enquanto digita
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Símbolos de diagnóstico personalizados
local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "»" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Tema TokyoNight
vim.cmd[[colorscheme tokyonight]]

-- Lualine com ícones
require('lualine').setup {
  options = {
    theme = 'tokyonight',
    icons_enabled = true,
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename'},
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = '✘ ', warn = '▲ ', info = '» ', hint = '⚑ ' },
        diagnostics_color = {
          error = 'DiagnosticError',
          warn  = 'DiagnosticWarn',
          info  = 'DiagnosticInfo',
          hint  = 'DiagnosticHint',
        },
      },
      'encoding',
      'fileformat',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}

-- Configuração do Trouble (lista de erros)
require("trouble").setup {
  position = "bottom",
  height = 10,
  width = 50,
  icons = true,
  mode = "workspace_diagnostics",
  fold_open = "",
  fold_closed = "",
  group = true,
  padding = true,
  action_keys = {
    close = "q",
    cancel = "<esc>",
    refresh = "r",
    jump = {"<cr>", "<tab>"},
    open_split = { "<c-x>" },
    open_vsplit = { "<c-v>" },
    open_tab = { "<c-t>" },
    jump_close = {"o"},
    toggle_mode = "m",
    toggle_preview = "P",
    hover = "K",
    preview = "p",
    close_folds = {"zM", "zm"},
    open_folds = {"zR", "zr"},
    toggle_fold = {"zA", "za"},
    previous = "k",
    next = "j"
  },
  indent_lines = true,
  auto_open = false,
  auto_close = false,
  auto_preview = true,
  auto_fold = false,
  auto_jump = {"lsp_definitions"},
  signs = {
    error = "✘",
    warning = "▲",
    hint = "⚑",
    information = "»"
  },
  use_diagnostic_signs = false
}

-- ToggleTerm: terminal horizontal embaixo (APENAS F5)
require('toggleterm').setup {
  open_mapping = [[<F5>]],
  direction = 'horizontal',
  size = 15,
  shade_terminals = true,
  start_in_insert = true,
  persist_size = true,
}

-- Atalho F5 para terminal
vim.keymap.set('n', '<F5>', ':ToggleTerm<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<F5>', '<C-o>:ToggleTerm<CR>', { noremap = true, silent = true })

-- ========== ATALHOS ESTILO IDE ==========
-- Undo/Redo
vim.keymap.set('n', '<C-z>', 'u', { noremap = true, silent = true })
vim.keymap.set('n', '<C-y>', '<C-r>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-z>', '<C-o>u', { noremap = true, silent = true })
vim.keymap.set('i', '<C-y>', '<C-o><C-r>', { noremap = true, silent = true })

-- Salvar
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-s>', '<C-o>:w<CR>', { noremap = true, silent = true })

-- Selecionar tudo
vim.keymap.set('n', '<C-a>', 'ggVG', { noremap = true, silent = true })

-- Copiar, recortar, colar
vim.keymap.set('v', '<C-c>', '"+y', { noremap = true, silent = true })
vim.keymap.set('v', '<C-x>', '"+d', { noremap = true, silent = true })
vim.keymap.set('n', '<C-v>', '"+p', { noremap = true, silent = true })
vim.keymap.set('i', '<C-v>', '<C-o>"+p', { noremap = true, silent = true })

-- ========== CORREÇÕES PARA NAVEGAÇÃO COM SETAS ==========
-- Setas básicas (mantém comportamento padrão, mas com whichwrap)
vim.keymap.set('n', '<Left>', 'h', { noremap = true, silent = true })
vim.keymap.set('n', '<Right>', 'l', { noremap = true, silent = true })
vim.keymap.set('n', '<Up>', 'k', { noremap = true, silent = true })
vim.keymap.set('n', '<Down>', 'j', { noremap = true, silent = true })

-- Setas no insert mode
vim.keymap.set('i', '<Left>', '<Left>', { noremap = true, silent = true })
vim.keymap.set('i', '<Right>', '<Right>', { noremap = true, silent = true })
vim.keymap.set('i', '<Up>', '<Up>', { noremap = true, silent = true })
vim.keymap.set('i', '<Down>', '<Down>', { noremap = true, silent = true })

-- ========== SELEÇÃO COM SHIFT+SETAS ==========
-- Seleção com Shift+Setas (caracteres) - atravessa linhas
vim.keymap.set('n', '<S-Right>', 'vl', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Left>', 'vh', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Down>', 'vj', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Up>', 'vk', { noremap = true, silent = true })
vim.keymap.set('v', '<S-Right>', 'l', { noremap = true, silent = true })
vim.keymap.set('v', '<S-Left>', 'h', { noremap = true, silent = true })
vim.keymap.set('v', '<S-Down>', 'j', { noremap = true, silent = true })
vim.keymap.set('v', '<S-Up>', 'k', { noremap = true, silent = true })

-- Seleção com Ctrl+Shift+Setas (palavras)
vim.keymap.set('n', '<C-S-Right>', 'vw', { noremap = true, silent = true })
vim.keymap.set('n', '<C-S-Left>', 'vb', { noremap = true, silent = true })
vim.keymap.set('n', '<C-S-Down>', 'vj', { noremap = true, silent = true })
vim.keymap.set('n', '<C-S-Up>', 'vk', { noremap = true, silent = true })
vim.keymap.set('v', '<C-S-Right>', 'w', { noremap = true, silent = true })
vim.keymap.set('v', '<C-S-Left>', 'b', { noremap = true, silent = true })
vim.keymap.set('v', '<C-S-Down>', 'j', { noremap = true, silent = true })
vim.keymap.set('v', '<C-S-Up>', 'k', { noremap = true, silent = true })

-- ========== INDENTAÇÃO MELHORADA ==========
-- Tab/Shift+Tab para indentar/desindentar no modo normal
vim.keymap.set('n', '<Tab>', '>>', { noremap = true, silent = true, desc = "Indentar linha" })
vim.keymap.set('n', '<S-Tab>', '<<', { noremap = true, silent = true, desc = "Desindentar linha" })

-- Tab/Shift+Tab no modo visual (mantém seleção)
vim.keymap.set('v', '<Tab>', '>gv', { noremap = true, silent = true, desc = "Indentar seleção" })
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true, desc = "Desindentar seleção" })

-- Shift+Tab no insert mode para desindentar
vim.keymap.set('i', '<S-Tab>', '<C-d>', { noremap = true, silent = true, desc = "Desindentar no insert mode" })

-- Atalhos alternativos para indentação (Ctrl+] e Ctrl+[)
vim.keymap.set('n', '<C-]>', '>>', { noremap = true, silent = true, desc = "Indentar linha" })
vim.keymap.set('n', '<C-[>', '<<', { noremap = true, silent = true, desc = "Desindentar linha" })
vim.keymap.set('v', '<C-]>', '>gv', { noremap = true, silent = true, desc = "Indentar seleção" })
vim.keymap.set('v', '<C-[>', '<gv', { noremap = true, silent = true, desc = "Desindentar seleção" })

-- Navegação entre janelas (mais fácil)
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })  -- Esquerda
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })  -- Baixo
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })  -- Cima
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })  -- Direita

-- Fechar buffer/aba
vim.keymap.set('n', '<C-w>', ':bd<CR>', { noremap = true, silent = true })

-- ========== ATALHOS PARA DIAGNÓSTICOS ==========
-- Navegar entre erros
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Próximo erro" })
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "Erro anterior" })
-- Mostrar erro flutuante
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Mostrar erro" })
-- Lista de todos os erros
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { noremap = true, silent = true, desc = "Lista de erros" })
-- Trouble (lista visual de erros)
vim.keymap.set('n', '<leader>dt', ':TroubleToggle<CR>', { noremap = true, silent = true, desc = "Toggle lista de erros" })

-- Função on_attach para mapeamento personalizado dentro do nvim-tree
local function on_attach(bufnr)
  local api = require('nvim-tree.api')
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<Space>', api.node.open.edit, opts('Open'))
end

-- Configuração nvim-tree
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
  filters = {
    dotfiles = true,
  },
  on_attach = on_attach,
})

-- Atalho para abrir/fechar o nvim-tree
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', { noremap=true, silent=true })

-- ========== CONFIGURAÇÃO NVIM-CMP CORRIGIDA ==========
local cmp = require'cmp'
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    -- Tab para navegar nas sugestões
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-expand-or-jump)", true, true, true), "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- Permite que Tab funcione normalmente (indentação)
      end
    end, { "i", "s" }),
    -- Shift+Tab para navegar nas sugestões (anterior) - CORRIGIDO
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>(vsnip-jump-prev)", true, true, true), "")
      else
        -- Se não há sugestões, permite que Shift+Tab funcione como desindentar
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'path' },
  }
}

-- Configuração do nvim-autopairs
require('nvim-autopairs').setup({
  check_ts = true,
  ts_config = {
    lua = {'string', 'source'},
    javascript = {'string', 'template_string'},
    java = false,
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
  fast_wrap = {
    map = '<M-e>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = [=[[%'%"%>%]%)%}%,]]=],
    offset = 0,
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'PmenuSel',
    highlight_grey = 'LineNr'
  },
})

-- Integração do nvim-autopairs com nvim-cmp
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- Capabilities LSP (suporte a snippet)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Função on_attach para LSP
local function on_attach_lsp(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)

  -- Highlight do símbolo sob o cursor
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Document Highlight",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Clear All the References",
    })
  end
end

-- Configuração LSP para Python (pyright) e Go (gopls)
local lspconfig = require('lspconfig')
lspconfig.pyright.setup{
  capabilities = capabilities,
  on_attach = on_attach_lsp,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
        typeCheckingMode = "basic"
      }
    }
  }
}
lspconfig.gopls.setup{
  capabilities = capabilities,
  on_attach = on_attach_lsp,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}

-- Configuração básica treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = { "python", "go", "lua" },
  highlight = { enable = true },
  indent = { enable = true },
}

-- Atalhos básicos Telescope
vim.api.nvim_set_keymap('n', '<Leader>ff', ':Telescope find_files<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<Leader>fg', ':Telescope live_grep<CR>', { noremap=true, silent=true })

-- Auto-comando para mostrar diagnósticos ao parar o cursor
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})

-- ========== MENSAGEM DE CONFIRMAÇÃO ==========
print("✅ Configuração Nvim carregada com correções:")
print("   • Shift+Tab desindenta corretamente")
print("   • Setas navegam entre linhas")
print("   • Tab/Shift+Tab funcionam com autocomplete")
print("   • Navegação melhorada com whichwrap")
