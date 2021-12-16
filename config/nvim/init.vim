
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~  Constants ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set mouse=a  " enable mouse
set encoding=utf-8
set number
set noswapfile
set scrolloff=7
set hidden " TextEdit might fail if hidden is not set.
set colorcolumn=120
set expandtab
set autoindent
set shortmess+=c "  Don't pass messages to |ins-completion-menu|.
set encoding=utf-8
set fileformat=unix
filetype indent on      " load filetype-specific indent files
set showtabline=2
set cmdheight=2 "  Give more space for displaying messages.
set updatetime=300
set clipboard=unnamed
set tabstop=2
set shiftwidth=2
set laststatus=2

" Map hotkeys to ru chars
:set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz


" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Custom shortcuts ~~~~~~~~~~~~~~~~~~~~~~~

" Save session
nnoremap <silent> <C-s> :mksession! ./session.vim

" Close the current buffer
nnoremap <silent>    <A-c> :BufferClose<CR>

" Navigate through the windows
nmap <silent> <A-k> :wincmd k<CR>
nmap <silent> <A-j> :wincmd j<CR>
nmap <silent> <A-h> :wincmd h<CR>
nmap <silent> <A-l> :wincmd l<CR>

" Split the window
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction
nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>


" turn off search highlight
nnoremap ,<space> :nohlsearch<CR>


call plug#begin('~/.vim/plugged')

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  Themes  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plug 'sainnhe/sonokai'
Plug 'sainnhe/everforest'
Plug 'morhetz/gruvbox' 
Plug 'mhartington/oceanic-next'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'ayu-theme/ayu-vim'

"colorscheme everforest
"set background=light
"let g:everforest_background = 'soft'


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  NerdTree  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plug 'scrooloose/nerdtree' |
    \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'

nmap ,<F6> :NERDTreeFind
nmap <F6> :NERDTreeToggle<CR>
nmap <Leader><F6> :NERDTreeFocus<CR>
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let NERDTreeShowHidden=1


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  Tabline ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'

" Move to previous/next
nnoremap <silent>    <A-,> :BufferPrevious<CR>
nnoremap <silent>    <A-.> :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
nnoremap <silent>    <A->> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <A-1> :BufferGoto 1<CR>
nnoremap <silent>    <A-2> :BufferGoto 2<CR>
nnoremap <silent>    <A-3> :BufferGoto 3<CR>
nnoremap <silent>    <A-4> :BufferGoto 4<CR>
nnoremap <silent>    <A-5> :BufferGoto 5<CR>
nnoremap <silent>    <A-6> :BufferGoto 6<CR>
nnoremap <silent>    <A-7> :BufferGoto 7<CR>
nnoremap <silent>    <A-8> :BufferGoto 8<CR>


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  COC ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ~~~~~~~~~~ Settings ~~~~~~~~~~~~~
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

"~~~~~~~~~~~~~~~~ COC Git ~~~~~~~~~
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)
nmap gc <Plug>(coc-git-commit)
nmap gs <Plug>(coc-git-chunkinfo)

"~~~~~~~~~~~~~~~ COC LSP ~~~~~~~~~~

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json, python, go setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

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


" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR> 

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  Semantic Highlight ~~~~~~~~~~~~~~~~~~~~~~~~
Plug 'jaxbot/semantic-highlight.vim'


autocmd BufWinEnter * :SemanticHighlightToggle
nnoremap <Leader>s :SemanticHighlightToggle<cr>


" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  FZF  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

nmap <F1> :GFiles<CR>


" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ StatusLine  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plug 'liuchengxu/eleline.vim'


" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  Commenter  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plug 'preservim/nerdcommenter'


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  For JS/JSX  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

call plug#end()

if has('termguicolors')
  set termguicolors
endif

" The configuration options should be placed before `colorscheme sonokai`.
colorscheme sonokai
let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
