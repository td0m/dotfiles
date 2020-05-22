" text generated with
" https://fsymbols.com/generators/tarty/

if !exists('g:vscode')
  " neovide
  set guifont=Fira\Code\ Nerd\ Font:h14
  let g:neovide_cursor_antialiasing=v:true
  let g:neovide_cursor_vfx_mode = "ripple"
  let g:neovide_refresh_rate=60

  "░██████╗████████╗██╗░░░██╗██╗░░░░░███████╗
  "██╔════╝╚══██╔══╝╚██╗░██╔╝██║░░░░░██╔════╝
  "╚█████╗░░░░██║░░░░╚████╔╝░██║░░░░░█████╗░░
  "░╚═══██╗░░░██║░░░░░╚██╔╝░░██║░░░░░██╔══╝░░
  "██████╔╝░░░██║░░░░░░██║░░░███████╗███████╗
  "╚═════╝░░░░╚═╝░░░░░░╚═╝░░░╚══════╝╚══════╝
  " leader
  let mapleader = " "
  " spell check
  set spelllang=en_gb
  autocmd FileType latex,tex,md,markdown,txt setlocal spell
  " indentation
  set tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent smartindent
  " relative lines
  set number relativenumber
  " other
  set hidden nobackup nowritebackup cmdheight=1 updatetime=300 shortmess+=c signcolumn=yes noshowmode
  set splitright splitbelow

  "███╗░░██╗░█████╗░██╗░░░██╗██╗░██████╗░░█████╗░████████╗██╗░█████╗░███╗░░██╗
  "████╗░██║██╔══██╗██║░░░██║██║██╔════╝░██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║
  "██╔██╗██║███████║╚██╗░██╔╝██║██║░░██╗░███████║░░░██║░░░██║██║░░██║██╔██╗██║
  "██║╚████║██╔══██║░╚████╔╝░██║██║░░╚██╗██╔══██║░░░██║░░░██║██║░░██║██║╚████║
  "██║░╚███║██║░░██║░░╚██╔╝░░██║╚██████╔╝██║░░██║░░░██║░░░██║╚█████╔╝██║░╚███║
  "╚═╝░░╚══╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝
  " turn terminal to normal mode with escape
  tnoremap <Esc> <C-\><C-n>
  "Faster escape
  :imap jk <Esc>
  :imap kj <Esc>
  " move between split/vsplit panels
  nnoremap <C-j> <C-W><C-J>
  nnoremap <C-k> <C-W><C-K>
  nnoremap <C-l> <C-W><C-L>
  nnoremap <C-h> <C-W><C-H>
  tnoremap <C-j> <C-\><C-n><C-W><C-J>
  tnoremap <C-k> <C-\><C-n><C-W><C-K>
  "tnoremap <C-l> <C-\><C-n><C-W><C-L>
  tnoremap <C-h> <C-\><C-n><C-W><C-H>
  " move between tabs
  nnoremap <A-h> gT
  nnoremap <A-l> gt
  nnoremap <silent> <A-1> 1gt
  nnoremap <silent> <A-2> 2gt
  nnoremap <silent> <A-3> 3gt
  nnoremap <silent> <A-4> 4gt
  nnoremap <silent> <A-5> 4gt

  " toggle terminal
  let g:term_buf = 0
  let g:term_win = 0
  let g:height = 12
  function! TermToggle()
      if win_gotoid(g:term_win)
          hide
      else
          botright new
          exec "resize " . g:height
          try
              exec "buffer " . g:term_buf
          catch
              call termopen($SHELL, {"detach": 0})
              let g:term_buf = bufnr("")
              set nonumber
              set norelativenumber
              set signcolumn=no
          endtry
          "set notermguicolors
          startinsert!
          let g:term_win = win_getid()
      endif
  endfunction
  nnoremap <A-t> :call TermToggle()<CR>
  inoremap <A-t> :call TermToggle()<CR>
  tnoremap <A-t> <C-\><C-n>:call TermToggle()<CR>

  "██████╗░██╗░░░░░██╗░░░██╗░██████╗░██╗███╗░░██╗░██████╗
  "██╔══██╗██║░░░░░██║░░░██║██╔════╝░██║████╗░██║██╔════╝
  "██████╔╝██║░░░░░██║░░░██║██║░░██╗░██║██╔██╗██║╚█████╗░
  "██╔═══╝░██║░░░░░██║░░░██║██║░░╚██╗██║██║╚████║░╚═══██╗
  "██║░░░░░███████╗╚██████╔╝╚██████╔╝██║██║░╚███║██████╔╝
  "╚═╝░░░░░╚══════╝░╚═════╝░░╚═════╝░╚═╝╚═╝░░╚══╝╚═════╝░
  call plug#begin('~/.vim/plugged')
    " Color themes
    Plug 'arzg/vim-colors-xcode'
    Plug 'tomasiser/vim-code-dark'

    " Language Server
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Languages
    Plug 'fatih/vim-go', { 'for': 'go' }
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
    Plug 'lervag/vimtex'
    Plug 'vimwiki/vimwiki'
    Plug 'posva/vim-vue'
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'
    Plug 'mxw/vim-jsx'
    Plug 'peitalin/vim-jsx-typescript'

    " File Explorer with Icons
    Plug 'scrooloose/nerdtree'
    Plug 'ryanoasis/vim-devicons'

    " File Search
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " Wakatime
    Plug 'wakatime/vim-wakatime'
    Plug 'tpope/vim-fugitive'

    " Line
    Plug 'itchyny/lightline.vim'

    " (La)Tex support
    "Plug 'wikitopian/hardmode'
    
    " Welcome/Splash screen
    Plug 'mhinz/vim-startify'

    Plug 'preservim/nerdcommenter'
    Plug 'tpope/vim-fugitive'
    Plug 'yuttie/comfortable-motion.vim'

    " Editing
    Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
    Plug 'gyim/vim-boxdraw'

  call plug#end()

  nnoremap <silent> <A-g>  :Goyo<CR>

  "██╗░░░░░░██████╗██████╗░
  "██║░░░░░██╔════╝██╔══██╗
  "██║░░░░░╚█████╗░██████╔╝
  "██║░░░░░░╚═══██╗██╔═══╝░
  "███████╗██████╔╝██║░░░░░
  "╚══════╝╚═════╝░╚═╝░░░░░
  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
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

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
  " position. Coc only does snippet and additional edit on confirm.
  if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <leader>rn <Plug>(coc-rename)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  nmap <leader>ac  <Plug>(coc-codeaction)
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Introduce function text object
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap if <Plug>(coc-funcobj-i)
  omap af <Plug>(coc-funcobj-a)

  " Use <TAB> for selections ranges.
  " NOTE: Requires 'textDocument/selectionRange' support from the language server.
  " coc-tsserver, coc-python are the examples of servers that support it.
  nmap <silent> <TAB> <Plug>(coc-range-select)
  xmap <silent> <TAB> <Plug>(coc-range-select)

  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)
  command! -nargs=? Unfold :0,$foldopen
  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  "set st * silent call CocActionAsync('highlight')
  autocmd CursorHold * silent call CocActionAsync('doHover')
  nnoremap <silent> <leader>k :call CocAction('doHover')<CR>
  "format
  nnoremap <silent> <leader>f :call CocAction('format')<CR>:w<CR>
  " Show all diagnostics.
  nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions.
  nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
  " Show commands.
  nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
  " Find symbol of current document.
  nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
  " Search workspace symbols.
  nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
  " Resume latest coc list.
  nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>


  "███╗░░██╗███████╗██████╗░██████╗░  ████████╗██████╗░███████╗███████╗
  "████╗░██║██╔════╝██╔══██╗██╔══██╗  ╚══██╔══╝██╔══██╗██╔════╝██╔════╝
  "██╔██╗██║█████╗░░██████╔╝██║░░██║  ░░░██║░░░██████╔╝█████╗░░█████╗░░
  "██║╚████║██╔══╝░░██╔══██╗██║░░██║  ░░░██║░░░██╔══██╗██╔══╝░░██╔══╝░░
  "██║░╚███║███████╗██║░░██║██████╔╝  ░░░██║░░░██║░░██║███████╗███████╗
  "╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝╚═════╝░  ░░░╚═╝░░░╚═╝░░╚═╝╚══════╝╚══════╝
  let g:NERDTreeShowHidden = 1
  let g:NERDTreeMinimalUI = 1
  let g:NERDTreeIgnore = []
  let g:NERDTreeStatusline = ''
  " Automaticaly close nvim if NERDTree is only thing left open
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  nnoremap <silent> <A-b> :NERDTreeToggle<CR>

  " FZF
  nnoremap <C-t> :FZF<CR>
  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit'
    \}
  " requires silversearcher-ag
  " used to ignore gitignore files
  let $FZF_DEFAULT_COMMAND = 'ag -g ""'


  "██╗░░░░░░█████╗░████████╗███████╗██╗░░██╗
  "██║░░░░░██╔══██╗╚══██╔══╝██╔════╝╚██╗██╔╝
  "██║░░░░░███████║░░░██║░░░█████╗░░░╚███╔╝░
  "██║░░░░░██╔══██║░░░██║░░░██╔══╝░░░██╔██╗░
  "███████╗██║░░██║░░░██║░░░███████╗██╔╝╚██╗
  "╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚══════╝╚═╝░░╚═╝
  let g:tex_flavor='latex'
  let g:vimtex_view_method='zathura'
  let g:vimtex_quickfix_mode=0
  set conceallevel=1
  let g:tex_conceal='abdmg'
  let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : 'output',
  \}

  "████████╗██╗░░██╗███████╗███╗░░░███╗██╗███╗░░██╗░██████╗░
  "╚══██╔══╝██║░░██║██╔════╝████╗░████║██║████╗░██║██╔════╝░
  "░░░██║░░░███████║█████╗░░██╔████╔██║██║██╔██╗██║██║░░██╗░
  "░░░██║░░░██╔══██║██╔══╝░░██║╚██╔╝██║██║██║╚████║██║░░╚██╗
  "░░░██║░░░██║░░██║███████╗██║░╚═╝░██║██║██║░╚███║╚██████╔╝
  "░░░╚═╝░░░╚═╝░░╚═╝╚══════╝╚═╝░░░░░╚═╝╚═╝╚═╝░░╚══╝░╚═════╝░
  syntax on
  set t_Co=256
  set t_ut=
  if (has('termguicolors'))
    set termguicolors
  endif

  colorscheme xcodedarkhc
  "let g:lightline = {
    "\ 'colorscheme': 'codedark',
  "\ }
endif
