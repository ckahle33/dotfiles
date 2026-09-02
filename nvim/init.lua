-- Zero plugins, on purpose. Everything here ships with Neovim.
-- There is no plugin directory, no manager, no lockfile, nothing to update.
-- Ported from the old vimrc; the notes say which plugin each part replaced.

vim.g.mapleader = " "

-- ─────────────────────────────────────────────────────────────
-- OPTIONS
-- ─────────────────────────────────────────────────────────────
local o = vim.o

o.number = true
o.mouse = "a"
o.splitright = true
o.cursorline = true
o.ignorecase = true
o.smartcase = true
o.clipboard = "unnamedplus"
o.swapfile = false
o.undofile = true          -- persistent undo beats the old :GundoToggle
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.termguicolors = true
o.scrolloff = 3
o.splitbelow = true
o.confirm = true           -- prompt instead of failing on :q with changes

-- :find searches the whole tree, which is the plugin-free fuzzy open.
o.path = vim.o.path .. ",**"
o.wildmenu = true
o.wildoptions = "pum"      -- completion in a popup, not a cramped statusline
o.wildignore = "*/node_modules/*,*/vendor/*,*/.git/*,*/dist/*"

-- ag is installed; wire it to :grep so <leader>f needs nothing else.
if vim.fn.executable("ag") == 1 then
  o.grepprg = "ag --vimgrep"
  o.grepformat = "%f:%l:%c:%m"
end

-- Built-in colorscheme. Others bundled: retrobox, sorbet, wildcharm, slate.
vim.cmd.colorscheme("habamax")

-- Native statusline -- this is the whole of what vim-airline was doing.
o.statusline = " %f %m%r%= %{&filetype} %l:%c  %P "
o.laststatus = 3           -- one global statusline, not one per split

-- ─────────────────────────────────────────────────────────────
-- KEYS
-- ─────────────────────────────────────────────────────────────
local map = vim.keymap.set

map("n", "U", "<C-r>")
map("n", "k", "gk")        -- treat wrapped lines as lines
map("n", "j", "gj")
map("n", "<CR>", "o<Esc>")

-- tabs
map("n", "<S-l>", "gt")
map("n", "<S-h>", "gT")
map("n", "<S-t>", "<cmd>tabnew<cr>")
map("n", "<S-q>", "<cmd>tabc<cr>")

-- search / open
map("n", "<leader>f", ":grep ")
map("n", "<leader>p", ":find ")

-- splits and files
map("n", "<leader>v", "<cmd>vsp<cr>")
map("n", "<leader>s", "<cmd>sp<cr>")
map("n", "<leader>q", "<cmd>q<cr>")
map("n", "<leader>w", "<cmd>w<cr>")
map("n", "<leader>,", "<C-^>")
map("n", "<leader>ra", ":%s/")
map("n", "-", "<C-w>20<")
map("n", "=", "<C-w>20>")
map("n", "<leader>o", "<C-o>")
map("n", "<leader>]", "<C-]>")

-- netrw sidebar, standing in for NERDTree
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 22
map("n", "<leader>d", "<cmd>Lexplore<cr>")

-- Alignment, replacing vim-easy-align. Visual-select, then <leader>a.
map("x", "<leader>a", ":!column -t<cr>")

-- Expand to the current file's directory, as the old cnoremap %% did.
map("c", "%%", function() return vim.fn.expand("%:h") .. "/" end, { expr = true })

-- ─────────────────────────────────────────────────────────────
-- AUTOCMDS
-- ─────────────────────────────────────────────────────────────
local aug = vim.api.nvim_create_augroup("init", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = aug,
  desc = "strip trailing whitespace",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[silent! %s/\s\+$//e]])
    pcall(vim.api.nvim_win_set_cursor, 0, pos)
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = aug,
  desc = "flash what was yanked",
  callback = function() vim.hl.on_yank({ timeout = 150 }) end,
})

-- ─────────────────────────────────────────────────────────────
-- LSP  (core client, 0.11+ -- no nvim-lspconfig, no completion plugin)
-- Servers are ordinary binaries; see `make deps`.
-- ─────────────────────────────────────────────────────────────
vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork" },
  root_markers = { "go.work", "go.mod", ".git" },
})

vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  root_markers = { "tsconfig.json", "package.json", ".git" },
})

vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
})

vim.lsp.enable({ "gopls", "ts_ls", "pyright" })

vim.diagnostic.config({
  virtual_text = { prefix = "-" },
  severity_sort = true,
  float = { border = "rounded" },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = aug,
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    -- Built-in autocompletion. No cmp, no snippet engine.
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = true })
    end
    -- 0.11 already maps grn rename, gra code action, grr references, K hover, gO symbols.
    map("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf })
    map("n", "<leader>e", vim.diagnostic.open_float, { buffer = ev.buf })
    -- Format Go on save, which is the one vim-go habit worth keeping.
    if client and client.name == "gopls" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = aug,
        buffer = ev.buf,
        callback = function() vim.lsp.buf.format({ async = false }) end,
      })
    end
  end,
})
