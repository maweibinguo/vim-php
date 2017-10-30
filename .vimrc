set encoding=utf8 "设置当前字符编码为 UTF-8

set termencoding=utf-8

" PHP 自动完成
" 设置自动完成的监听方式：尾部添加一个字母和清除一个字母
set complete-=k complete+=k

" 设置字典补全文件
set dictionary=/root/PHP.func

" 使用 tab 键自动完成或尝试自动完成
function! InsertTabWrapper()
    let col=col('.')-1
    if !col || getline('.')[col-1] !~ '\k'
        return "\<TAB>"
    else
        return "\<C-N>"
    endif
endfunction

" 重新映射 tab 键到 InsertTabWrapper 函数
inoremap <TAB> <C-R>=InsertTabWrapper()<CR>

set expandtab "<Tab>键会插入一系列的空格。这样你可以获得如同插入一个制表符 一样数量的空格。但你的文件中并不包含真正的制表符。 退格键 (<BS>) 每次只能删除一个空格。这样如果你键入了一个 <Tab>，你需要键入 8 次 <BS> 才能恢复

set tabstop=4 "表示按一个tab之后，显示出来的相当于几个空格，默认的是8个。 

%retab "设定 'expandtab' 选项并不会影响已有的制表符。如果你想将制表符转换为空格,可以使用该命令, 所有非空字符后的制表符不会受到影响

set shiftwidth=4 "每一级缩进是多少个空格

set number "打开时显示行号

set selection=inclusive "指定在选择文本时，光标所在位置也属于被选中的范围。

set lbr "不在单词中间断行。设置了这个选项后，如果一行文字非常长，无法在一行内显示完的话它会在单词与单词间的空白处断开，尽量不会把一个单词分成两截放在两个不同的行里

set ambiwidth=double "防止特殊符号无法正常显示

set whichwrap=b,s,<,>,[,]	"默认情况下，在 VIM 中当光标移到一行最左边的时候，我们继续按左键，光标不能回到上一行的最右边。同样地，光标到了一行最右边的时候，我们不能通过继续按右跳到下一行的最左边。但是，通过设置 whichwrap 我们可以对一部分按键开启这项功能

set wildmenu "在命令模式下使用 tab 自动补全的时候，将补全内容使用一个漂亮的单行菜单形式显示出来

colo molokai "指定配色方案，首先需要知道有那些配色方案，在/usr/share/vim/vim（版本不同名字可能有所不同）~/.vim/colors


" =================================== php语法检查插件 ========================================
let g:PHP_SYNTAX_CHECK_BIN = '/usr/local/php/5.6.22/bin/php'

autocmd BufWritePost *.php call PHPSyntaxCheck()
if !exists('g:PHP_SYNTAX_CHECK_BIN')
    let g:PHP_SYNTAX_CHECK_BIN = 'php'
endif
function! PHPSyntaxCheck()
    let result = system(g:PHP_SYNTAX_CHECK_BIN.' -l -n '.expand('%'))
    if (stridx(result, 'No syntax errors detected') == -1)
        echohl WarningMsg | echo result | echohl None
    endif
endfunction

" =================================== vund插件的配置 ========================================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" added nerdtree
Plugin 'scrooloose/nerdtree'

" ctrlp 类似sublime
Plugin 'https://github.com/kien/ctrlp.vim.git'

" html/css 插件
Plugin 'https://github.com/mattn/emmet-vim.git'

" closetag 自动补全另一半标签
Plugin 'https://github.com/docunext/closetag.vim.git'

" powerline
Plugin 'https://github.com/Lokaltog/vim-powerline.git'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"

" =======================================nerdtree插件配置=================================================
"在 vim 启动的时候默认开启 NERDTree（autocmd 可以缩写为 au）
"autocmd VimEnter * NERDTree

"将 NERDTree 的窗口设置在 vim 窗口的右侧（默认为左侧）
let NERDTreeWinPos="right"

" 按下 F2 调出/隐藏 NERDTree
map <F2> :NERDTreeToggle<CR>

" 当打开 NERDTree 窗口时，自动显示 Bookmarks
"let NERDTreeShowBookmarks=1


" =======================================ctrlp插件配置=====================================================
set wildignore+=*/tmp/*,*.so,*.swp,*.zip 
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
    \ }

let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
autocmd BufEnter * cd %:p:h

" =======================================powerline插件配置=====================================================
set laststatus=2
set t_Co=256
let g:Powerline_symbols='unicode'

" =======================================vim-airline插件配置==================================================
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='wombat'
