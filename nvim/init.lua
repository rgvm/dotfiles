-- plugins
vim.pack.add({
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
    { src = 'https://github.com/mbbill/undotree' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/nvim-telescope/telescope.nvim',  version = 'v0.2.0' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-context' },
    { src = 'https://github.com/sainnhe/gruvbox-material' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/tpope/vim-fugitive' },
    { src = 'https://github.com/tpope/vim-surround' },
})

-- lsp config
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" } }
        }
    }
})
vim.diagnostic.config({ virtual_text = true })
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})
vim.cmd("set completeopt+=noselect") -- don't autoselect first LSP suggestion

vim.lsp.enable { "clangd", "lua_ls" }

require("nvim-treesitter").install { "c", "cpp", "lua" }
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

require("oil").setup()

-- basic settings
vim.opt.backup = false
vim.opt.cursorline = true
vim.opt.hlsearch = false
vim.opt.scrolloff = 8
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.opt.winborder = "rounded"
vim.opt.wrap = false

-- color
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_better_performance = 1
vim.cmd('colorscheme gruvbox-material')
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" }) -- gitsigns column

-- indentation
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "typescript", "html", "c", "cpp", "cc" },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.tabstop = 2
    end,
})

-- split settings
vim.opt.splitbelow = true
vim.opt.splitright = true

-- hybrid line numbering
vim.opt.number = true
vim.opt.relativenumber = true
local numbertoggle = vim.api.nvim_create_augroup('numbertoggle', {})
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
    group = numbertoggle,
    callback = function()
        vim.opt.relativenumber = true
    end,
})
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
    group = numbertoggle,
    callback = function()
        vim.opt.relativenumber = false
    end,
})

-- set mapleader as space
vim.keymap.set('n', '<Space>', '<Nop>')
vim.g.mapleader = ' '

-- jj as escape in insert mode
vim.keymap.set('i', 'jj', '<Esc>')

-- yank text to the OSX clipboard
vim.keymap.set({ 'n', 'v', 'o' }, '<leader>y', '"*y')
vim.keymap.set({ 'n', 'v', 'o' }, '<leader>Y', '"*Y')

-- split navigation
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')

-- visual mode line moving
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- centered vertical navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- telescope bindings
vim.keymap.set('n', '\\', '<Cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<leader>b', '<Cmd>Telescope buffers<CR>')
vim.keymap.set('n', '<leader>/', '<Cmd>Telescope live_grep<CR>')

-- undo tree bindings
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- add j/k navigations to jumplist
vim.keymap.set('n', 'j', function()
    return vim.v.count > 1 and "m'" .. vim.v.count .. 'j' or 'j'
end, { expr = true })
vim.keymap.set('n', 'k', function()
    return vim.v.count > 1 and "m'" .. vim.v.count .. 'k' or 'k'
end, { expr = true })

-- lsp bindings
vim.keymap.set('n', '<leader><leader>', vim.lsp.buf.format)

-- disable mouse
vim.opt.mouse = ""

-- custom statusline
function Statusline()
    return '%< %F %m' .. ReadOnly() .. '%=%y ' .. RHS()
end

function ReadOnly()
    if vim.bo.readonly or not vim.bo.modifiable then
        return ' ' .. '[]'
    else
        return ''
    end
end

function RHS()
    local curr_col = vim.fn.virtcol('.')
    local num_cols = vim.fn.virtcol('$')
    local padding = math.max(0, 5 - #tostring(curr_col) - #tostring(num_cols))
    return string.rep(' ', padding + 1) .. 'Ͼ:' .. curr_col .. '/' .. num_cols
end

vim.opt.statusline = "%{%v:lua.Statusline()%}"
vim.opt.laststatus = 2
