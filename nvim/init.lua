-- plugins
vim.pack.add({
    { src = 'https://github.com/chriskempson/base16-vim' },
    { src = 'https://github.com/dense-analysis/ale' },
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
    { src = 'https://github.com/neoclide/coc.nvim', version = 'release' },
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/nvim-telescope/telescope.nvim', version = 'v0.2.0' },
    { src = 'https://github.com/stevearc/oil.nvim' },
    { src = 'https://github.com/tpope/vim-fugitive' },
    { src = 'https://github.com/tpope/vim-surround' },
})

require("oil").setup()

-- color
vim.g.base16colorspace=256  -- Access colors present in 256 colorspace
vim.cmd('colorscheme base16-gruvbox-dark-medium')

-- indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "typescript", "html", "c", "cpp", "cc" },
    callback = function()
        vim.opt_local.autoindent = true
        vim.opt_local.expandtab = true
        vim.opt_local.smartindent = true
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
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' },  {
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
vim.keymap.set({'n', 'v', 'o'}, '<leader>y', '"*y')
vim.keymap.set({'n', 'v', 'o'}, '<leader>Y', '"*Y')

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

-- add j/k navigations to jumplist
vim.keymap.set('n', 'j', function()
    return vim.v.count > 1 and "m'" .. vim.v.count .. 'j' or 'j'
end, { expr = true })
vim.keymap.set('n', 'k', function()
    return vim.v.count > 1 and "m'" .. vim.v.count .. 'k' or 'k'
end, { expr = true })

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
    local rhs = string.rep(' ', padding + 1)
    local rhs = rhs .. 'Ͼ:'
    local rhs = rhs .. curr_col
    local rhs = rhs .. '/'
    local rhs = rhs .. num_cols
    return rhs
end

vim.opt.statusline = "%{%v:lua.Statusline()%}"
vim.opt.laststatus = 2

vim.cmd([[
" coc.nvim keybinds
function! CheckBackspace() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" use <tab> to trigger completion or open autocomplete
inoremap <silent><expr> <Tab>
\ coc#pum#visible() ? coc#pum#confirm() :
\ CheckBackspace() ? "\<Tab>" :
\ coc#refresh()
" Ctrl-J and Ctrl-K to navigate autocomplete list.
inoremap <expr> <C-J> coc#pum#visible() ? coc#pum#next(1) : "\<C-J>"
inoremap <expr> <C-K> coc#pum#visible() ? coc#pum#prev(1) : "\<C-K>"
]])
