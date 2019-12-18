" Vim color file
" Maintainer:   ZhendongCao <zhendongcao@nettech-global.com>
" Version:  Modify by desert.vim, v1.1
" can refer : https://blog.csdn.net/mdl13412/article/details/8129904

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
    syntax reset
    endif
endif
let g:colors_name="czd@color"

hi Normal   guifg=White guibg=grey20

" highlight groups
hi Cursor   guibg=khaki guifg=slategrey
"hi CursorIM
"hi Directory
"hi DiffAdd
"hi DiffChange
"hi DiffDelete
"hi DiffText
"hi ErrorMsg
hi VertSplit    guibg=#c2bfa5 guifg=grey50 gui=none
hi Folded   guibg=grey30 guifg=gold
hi FoldColumn   guibg=grey30 guifg=tan
hi IncSearch    guifg=slategrey guibg=khaki
"hi LineNr
hi ModeMsg  guifg=goldenrod
hi MoreMsg  guifg=SeaGreen
hi NonText  guifg=LightBlue guibg=grey30
hi Question guifg=springgreen
hi Search   guibg=peru guifg=wheat
hi SpecialKey   guifg=yellowgreen
hi StatusLine   guibg=#c2bfa5 guifg=black gui=none
hi StatusLineNC guibg=#c2bfa5 guifg=grey50 gui=none
hi Title    guifg=indianred
hi Visual   gui=none guifg=khaki guibg=olivedrab
"hi VisualNOS
hi WarningMsg   guifg=salmon
"hi WildMenu
"hi Menu
"hi Scrollbar
"hi Tooltip

" syntax highlighting groups
hi Comment  guifg=SkyBlue
hi Constant guifg=#ffa0a0
hi Identifier   guifg=palegreen
hi Statement    guifg=khaki
hi PreProc  guifg=indianred
hi Type     guifg=darkkhaki gui=none
hi Special  guifg=navajowhite
"hi Underlined
hi Ignore   guifg=grey40
"hi Error
hi Todo     guifg=orangered guibg=yellow2

" color terminal definitions
hi SpecialKey   ctermfg=darkgreen
hi NonText  cterm=none ctermfg=darkblue
hi Directory    cterm=none ctermfg=darkblue
hi ErrorMsg cterm=none ctermfg=7 ctermbg=1
" Modified by zhendong on 2018/01/04 changed serch colors.
hi IncSearch    cterm=NONE ctermfg=52 ctermbg=106
" Modified by zhendong on 2017/12/05 changed highlight colors to Orange.
hi Search   cterm=NONE ctermfg=Black ctermbg=106
hi MoreMsg  ctermfg=darkgreen
hi ModeMsg  cterm=NONE ctermfg=brown
hi LineNr   ctermfg=242
hi Question ctermfg=green
hi StatusLine   cterm=none,reverse
hi StatusLineNC cterm=reverse
hi VertSplit    cterm=reverse
hi Title    ctermfg=5
hi Visual   cterm=reverse
hi VisualNOS    cterm=NONE,underline
hi WarningMsg   ctermfg=1
hi WildMenu ctermfg=0 ctermbg=3
hi Folded   ctermfg=darkgrey ctermbg=NONE
hi FoldColumn   ctermfg=darkgrey ctermbg=NONE
hi DiffAdd  ctermbg=4 term=none cterm=none
hi DiffChange   ctermbg=5 term=none cterm=none
" bold is *B* for cterm.
hi DiffDelete   cterm=none ctermfg=4 ctermbg=6
hi DiffText cterm=none ctermbg=1
hi Comment  ctermfg=darkcyan
" Modified by zhendong on 2017/12/05 changed "character" color.
hi Constant ctermfg=94
hi Special  ctermfg=5
hi Identifier   ctermfg=6
hi Statement    ctermfg=3
hi PreProc  ctermfg=5
hi Type     ctermfg=2
hi Underlined   cterm=underline ctermfg=5
hi Ignore   cterm=none ctermfg=7
hi Ignore   ctermfg=darkgrey
hi Error    cterm=none ctermfg=7 ctermbg=1

"vim: sw = 4
