set nocompatible              " be iMproved, required
filetype off                  " required

" ----------------
" init
" ----------------
"
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" ----------------
" plugin
" ----------------
"
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'file:///home/gmarik/path/to/plugin'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
call vundle#end()            " required
filetype plugin indent on    " required

" -----------------
" encode
" -----------------
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8                           " バッファの内容がファイルに書き込まれるときencodingからfileencodingに文字コード変換
set fileencodings=ucs-boms,utf-8,euc-jp,cp932    " 既存のファイルの編集を開始するときに考慮される文字エンコーディングのリスト

"-----------------
" general
"-----------------
"
syntax on
syntax enable
set modeline                         " モードラインの機能を有効化
set fileformats=unix,dos,mac         " ファイルを開いた時に改行コードを自動判定
set ambiwidth=double                 " 文字が崩れる問題を回避
set backspace=indent,eol,start       " Backspaceの有効化
set whichwrap=b,s,h,l,<,>,[,],~      " 行頭行末の左右移動で行をまたぐ
set visualbell                       " ビープ音を画面フラッシュにする設定
set hidden                           " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set wildmenu wildmode=list:full      " コマンドラインモードでTABキーによるファイル名補完を有効にする
set showcmd                          " 入力中のコマンドを表示
set autoread                         " 内容が変更されたら自動的に再読み込み
set nobackup                         " バックアップファイルを作成しない
set noswapfile                       " swap ファイルを作成しない

" -----------------
" indent
" -----------------
set expandtab                        " タブスペースを可変にする
set tabstop=4                        " タブを含むファイルを開いた時のスペース数
set softtabstop=4                    " タブを入力した時のスペース数
set autoindent                       " オートインデント
set smartindent                      " スマートインデント
set shiftwidth=4                     " vimが自動でインデントを行った際、設定する空白数
" ファイルの拡張子によって自動でインデントを変更
augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead .py setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead .php setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead .rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead .sh setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead .js setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead .html setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead .vue setf js setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END


" -----------------
" search
" -----------------
set ignorecase               " 検索時大文字と小文字を無視
set smartcase                " 大文字で検索したときのみ、大文字小文字を無視しない
set incsearch                " Enter を押さなくてもインタラクティブに検索実行
set history=500              " コマンドラインの履歴を500件保存する
set hlsearch                 " 検索語句のハイライト

" -----------------
" display
" -----------------
set showmatch                " 対応する括弧の強調
set title                    " 編集中のファイル名を表示
colorscheme desert           " カラースキームの設定
set ruler                    " カーソル位置表示
set number                   " 行番号の表示
set scrolloff=8              " 上下8行の視界を確保
set cursorline               " カーソル行強調
autocmd InsertEnter,InsertLeave set cursorline! " cursorline highlight only insert mode

"----------------
" statusline
"----------------
"
set statusline=%F           " ファイル名表示
set statusline+=%m          " 変更チェック表示
set statusline+=%r          " 読み込み専用かどうか表示
set statusline+=%h          " ヘルプページなら[HELP]と表示
set statusline+=%w          " プレビューウインドウなら[Prevew]と表示
set statusline+=%=          " これ以降は右寄せ表示
set statusline+=[ENC=%{&fileencoding}]     " file encoding
set statusline+=[LOW=%l/%L]                " 現在行数/全行数
set laststatus=2            " ステータスラインを常に表示(0:表示しない、1:2つ以上ウィンドウがある時だけ表示)
set showtabline=2           " Always display the tabline, even if there is only one tab
function! g:Date()
  return strftime("%x %H:%M")
endfunction
set statusline+=\ \%{g:Date()}
set completeopt=menuone

" -----------------
" others
" -----------------
set clipboard=unnamed        " yank したテキストをクリップボードに格納
set lazyredraw               " マクロなどの途中経過を描写しない
set ttyfast                  " 高速ターミナル接続を行う(スクロールが重くなる対策)
set showbreak=↪
set wrapscan
vnoremap v $h " select endline by vv
" color
set background=dark
try
colorscheme solarized
catch
endtry
set t_Co=256
highlight Normal ctermbg=none

" 全角スペースをハイライト
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction
if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif

" binary settings
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre .bin let &binary =1
  autocmd BufReadPost if &binary | silent %!xxd -g 1
  autocmd BufReadPost set ft=xxd | endif
  autocmd BufWritePre if &binary | %!xxd -r | endif
  autocmd BufWritePost if &binary | silent %!xxd -g 1
  autocmd BufWritePost set nomod | endif
augroup END

" -----------------
" key mapping
" -----------------
nnoremap <C-a> ^                       " 行頭へ移動
nnoremap <C-e> $                       " 行末へ移動
nnoremap n nzz                         " 検索対象が真ん中に来る
nnoremap N Nzz                         " 検索対象が真ん中に来る
nnoremap <C-c> :set paste<CR>          " ペーストモード
nnoremap <ESC><ESC> :nohlsearch<CR>    " 検索ハイライト取り消し
autocmd InsertLeave set nopaste

" auto parentheses
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>


" ----------------
" Basic Usage
" ----------------
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
