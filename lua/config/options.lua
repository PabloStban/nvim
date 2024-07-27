-- This file is automatically loaded by plugins.core
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Enable LazyVim auto format
vim.g.autoformat = true

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

local opt = vim.opt

-- Agregados
opt.textwidth = 0 -- Cambia 80 al ancho que desees
opt.wrap = true -- Hace que el texto se adapte al size de la terminal
-- Original
opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 3 -- global statusline
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = "⸱",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end

-- Folding
vim.opt.foldlevel = 99
vim.opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"

if vim.fn.has("nvim-0.9.0") == 1 then
  vim.opt.statuscolumn = [[%!v:lua.require'lazyvim.util'.ui.statuscolumn()]]
end

-- HACK: causes freezes on <= 0.9, so only enable on >= 0.10 for now
if vim.fn.has("nvim-0.10") == 1 then
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
else
  vim.opt.foldmethod = "indent"
end

vim.o.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- My options
-----------------------------------------------------------
-- Compilar
-----------------------------------------------------------
-- Función para realizar acciones basadas en la extensión del archivo
-- Llama a la función en el evento BufEnter (cuando se abre un nuevo archivo)

local cmd = vim.cmd -- execute Vim commands
function compilar()
  local full_filename = vim.fn.expand("%:t:r") -- Obtiene el nombre del archivo
  local file_extension = vim.fn.expand("%:e") -- Obtiene la extensión del archivo actually
  local current_file = vim.fn.expand("%:p:h") -- Obtiene el paht sin el archivo que se va a compilar
  local file_compilar = current_file .. "/" .. full_filename

  if file_extension == "py" then
    cmd([[botright split]])
    cmd([[resize 8]])
    --cmd([[:term python "]] .. file_path .. [[%"]])
    cmd([[:term python "%"]])
    --cmd([[:term echo "%"]])
  elseif file_extension == "tex" then
    cmd([[botright split]])
    cmd([[resize 8]])
    cmd([[:term pdflatex -output-directory="]] .. current_file .. [[" "%" && zathura "]] .. file_compilar .. [[.pdf"]])
  elseif file_extension == "c" then
    cmd([[botright split]])
    cmd([[resize 8]])
    cmd([[:term gcc "%" -o "]] .. file_compilar .. [[" && "]] .. file_compilar .. [["]])
  elseif file_extension == "sh" then
    cmd([[botright split]])
    cmd([[resize 8]])
    cmd([[:term ./"%"]])
    --cmd([[:term echo "%"]])
  elseif file_extension == "java" then
    cmd([[botright split]])
    cmd([[resize 8]])
    cmd([[:term javac "%" && java -cp "]] .. current_file .. [[" ]] .. full_filename)
  else
    cmd([[botright split]])
    cmd([[resize 8]])
    cmd([[:term echo Format no defined!!!!]])
  end
end

function flotante()
  cmd([[ToggleTerm direction='float']])
end

vim.cmd([[command Flotante lua flotante]])

vim.cmd([[command Compilar lua compilar()]])
vim.g.mkdp_path = "/home/pablo/.nvm/versions/node/v14.21.3/bin/node" -- Reemplaza '/ruta/a/tu/ejecutable/node' con la ruta correcta a tu ejecutable de Node.js
