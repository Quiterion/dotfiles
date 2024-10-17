let mapleader =","

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin()
    Plug 'tpope/vim-surround'
    Plug 'lervag/vimtex'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    "Plug 'sirver/ultisnips'
    Plug 'junegunn/goyo.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'scrooloose/nerdtree'


    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'hrsh7th/nvim-cmp', {'branch': 'main'} " Optional: For using slash commands and variables in the chat buffer
    Plug 'nvim-telescope/telescope.nvim', " Optional: For using slash commands
    Plug 'stevearc/dressing.nvim' " Optional: Improves `vim.ui.select`
    Plug 'olimorris/codecompanion.nvim', {'branch': 'main'}
call plug#end()

" Some basics:
	nnoremap c "_c
    set hidden
	set nocompatible
	syntax on
	set encoding=utf-8
	set number nu
    set relativenumber rnu
    set bg=dark
    set go=a
    set mouse=a
    set nohlsearch
    set clipboard+=unnamedplus
    set showcmd
    set noshowmode
    set noruler
    set foldmethod=indent
    set cursorline
    set nolinebreak
    set breakindent
    set scrolloff=0
    set inccommand=nosplit

" Airline settings
	let g:airline_theme='myterm'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_nr_show = 1

" Set color scheme
    set t_Co=256
    set notermguicolors
    colorscheme molokai_custom
    let g:markdown_fenced_languages = ['html', 'python', 'lua', 'vim', 'typescript', 'javascript']

"
" Vimtex-specific config
	set conceallevel=0
	let g:tex_flavor='latex'
	let g:vimtex_view_method='zathura'
	let g:vimtex_quickfix_mode=0
    let g:vimtex_compiler_latexmk = {
        \ 'build_dir' : '',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'hooks' : [],
        \ 'options' : [
        \  '-shell-escape',
        \  '-verbose',
        \  '-synctex=1',
        \  '-file-line-error',
        \  '-interaction=nonstopmode'
        \ ],
        \}
	let g:tex_conceal='abdmg'

" UltiSnips-specific config
	let g:UltiSnipsExpandTrigger = '<M-Tab>'
	let g:UltiSnipsJumpForwardTrigger = '<M-Tab>'
	"let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" Enable autocompletion:
	set wildmode=longest,list,full

" length of an actual \t character:
    set tabstop=4

" use shorter indentation for json scripts:
    autocmd FileType json setlocal tabstop=2

" length to use when editing text (eg. TAB and BS keys)
" (0 for ‘tabstop’, -1 for ‘shiftwidth’):
    set softtabstop=0

" length to use when shifting text (eg. <<, >> and == commands)
" (0 for ‘tabstop’):
    set shiftwidth=0

" round indentation to multiples of 'shiftwidth' when shifting text
" (so that it behaves like Ctrl-D / Ctrl-T):
    set shiftround

" if set, only insert spaces; otherwise insert \t and complete with spaces:
    set expandtab

" reproduce the indentation of the previous line:
    set autoindent

" keep indentation produced by 'autoindent' if leaving the line blank:
    set cpoptions+=I

" use language‐specific plugins for indenting (better):
"    filetype plugin indent on

" try to be smart (increase the indenting level after ‘{’,
" decrease it after ‘}’, and so on):
"    set smartindent

" a stricter alternative which works better for the C language:
"    set cindent

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Allow shiftwidth on comments
    set cinkeys-=0#
    set indentkeys-=0#

" Goyo plugin makes text more readable when writing prose:
    nmap <leader>g :Goyo<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	nmap <leader>o :setlocal spell! spelllang=en_au<CR>

" Splits open at the bottom and right, which is not-silly, unlike vim defaults.
	set splitbelow splitright

" Nerd tree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	let NERDTreeShowHidden=1

" Shortcutting split navigation, saving a keypress:
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l

" Check file in shellcheck:
	nmap <leader>s :!clear && shellcheck %<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Format SQL statement highlighted in visual mode
    xnoremap <silent>fs 99<:'<,'>!sqlformat -rs  --indent_width 2 --keywords upper -<CR>`[<c-v>`]0

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %
	autocmd VimLeave *.tex !texclear-nuke.sh

" Open all folds by default
    autocmd BufWinEnter * silent! :%foldopen!

" Ensure files are read as what I want:
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" Save file as sudo on files that require root permission (broken dunno why)
"	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Word count:
	autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>

" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

" === CoC config section ===

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

set cmdheight=1

" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c


" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>fc  <Plug>(coc-format-selected)
nmap <leader>fc  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
xmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <leader>qf <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" === Goyo Functions ===
function! s:goyo_enter()
    if executable('tmux') && strlen($TMUX)
        silent !tmux set status off
        silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    endif
    set bg=dark
    colorscheme molokai_custom
    set fillchars=eob:\ ,vert:\ ,
    set noshowcmd
    set nocursorline
    set scrolloff=999
    set linebreak
endfunction

function! s:goyo_leave()
    if executable('tmux') && strlen($TMUX)
        silent !tmux set status on
        silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    endif
    set bg=dark
    colorscheme molokai_custom
    set fillchars=
    set showcmd
    set cursorline
    set scrolloff=0
    set nolinebreak
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

nmap <leader>cc :CodeCompanionChat<cr>
lua << EOF
require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "anthropic",
    },
    inline = {
      adapter = "anthropic",
    },
    agent = {
      adapter = "anthropic",
    },
  },
  opts = {
    log_level = "DEBUG", -- or "TRACE"
  },
})
EOF


autocmd! User avante.nvim echom "avante loaded"
nmap <leader>aa :CodeCompanionChat<cr>
