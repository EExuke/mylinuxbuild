" Vim color file - mycolor_gray_modified
" Generated by zhendongcao 2018-11-01
set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "mycolor_gray_modified"

"hi SignColumn -- no settings --
"hi CTagsMember -- no settings --
"hi CTagsGlobalConstant -- no settings --
hi Normal guifg=#f5f0f5 guibg=#0f0d0f guisp=#0f0d0f gui=NONE ctermfg=255 ctermbg=233 cterm=NONE
"hi CTagsImport -- no settings --
"hi CTagsGlobalVariable -- no settings --
"hi SpellRare -- no settings --
"hi EnumerationValue -- no settings --
"hi TabLineSel -- no settings --
"hi CursorLine -- no settings --
"hi Union -- no settings --
"hi TabLineFill -- no settings --
"hi CursorColumn -- no settings --
"hi EnumerationName -- no settings --
"hi SpellCap -- no settings --
"hi SpellLocal -- no settings --
"hi DefinedName -- no settings --
"hi MatchParen -- no settings --
"hi LocalVariable -- no settings --
"hi SpellBad -- no settings --
"hi TabLine -- no settings --
"hi clear -- no settings --
hi IncSearch guifg=#1e3852 guibg=#f0e68c guisp=#f0e68c gui=NONE ctermfg=17 ctermbg=228 cterm=NONE
hi WildMenu guifg=#1a1a1a guibg=#804000 guisp=#804000 gui=NONE ctermfg=234 ctermbg=3 cterm=NONE
hi SpecialComment guifg=#ffdead guibg=NONE guisp=NONE gui=NONE ctermfg=223 ctermbg=NONE cterm=NONE
hi Typedef guifg=#d6d079 guibg=NONE guisp=NONE gui=NONE ctermfg=186 ctermbg=NONE cterm=NONE
hi Title guifg=#f2550c guibg=NONE guisp=NONE gui=NONE ctermfg=202 ctermbg=NONE cterm=NONE
"hi Folded guifg=#ffd900 guibg=#4d4d4d guisp=#4d4d4d gui=NONE ctermfg=220 ctermbg=239 cterm=NONE
hi Folded guibg=black guifg=grey40 ctermfg=0 ctermbg=109
hi PreCondit guifg=#e76767 guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE
hi Include guifg=#e76767 guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE
hi Float guifg=#bd6124 guibg=NONE guisp=NONE gui=NONE ctermfg=1 ctermbg=NONE cterm=NONE
hi StatusLineNC guifg=#080708 guibg=#c2bfa5 guisp=#c2bfa5 gui=NONE ctermfg=232 ctermbg=187 cterm=NONE
hi NonText guifg=#968696 guibg=#121212 guisp=#121212 gui=NONE ctermfg=246 ctermbg=233 cterm=NONE
hi DiffText guifg=NONE guibg=#753411 guisp=#753411 gui=NONE ctermfg=NONE ctermbg=3 cterm=NONE
hi ErrorMsg guifg=#fffcff guibg=#61100b guisp=#61100b gui=NONE ctermfg=15 ctermbg=52 cterm=NONE
hi Ignore guifg=#808080 guibg=NONE guisp=NONE gui=NONE ctermfg=8 ctermbg=NONE cterm=NONE
hi Debug guifg=#ffdead guibg=NONE guisp=NONE gui=NONE ctermfg=223 ctermbg=NONE cterm=NONE
hi PMenuSbar guifg=NONE guibg=#848688 guisp=#848688 gui=NONE ctermfg=NONE ctermbg=102 cterm=NONE
hi Identifier guifg=#9aff9a guibg=NONE guisp=NONE gui=NONE ctermfg=120 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#ffdead guibg=NONE guisp=NONE gui=NONE ctermfg=223 ctermbg=NONE cterm=NONE
hi Conditional guifg=#ccc676 guibg=NONE guisp=NONE gui=NONE ctermfg=186 ctermbg=NONE cterm=NONE
hi StorageClass guifg=#d6d079 guibg=NONE guisp=NONE gui=NONE ctermfg=186 ctermbg=NONE cterm=NONE
hi Todo guifg=#9e0909 guibg=#d1d158 guisp=#d1d158 gui=NONE ctermfg=124 ctermbg=185 cterm=NONE
hi Special guifg=#00cfd6 guibg=NONE guisp=NONE gui=NONE ctermfg=44 ctermbg=NONE cterm=NONE
hi LineNr guifg=#868686 guibg=NONE guisp=NONE gui=NONE ctermfg=102 ctermbg=NONE cterm=NONE
hi StatusLine guifg=#1a1a1a guibg=#c2bfa5 guisp=#c2bfa5 gui=NONE ctermfg=234 ctermbg=187 cterm=NONE
hi Label guifg=#d6d079 guibg=NONE guisp=NONE gui=NONE ctermfg=186 ctermbg=NONE cterm=NONE
hi PMenuSel guifg=#1a1a1a guibg=#c2bfa5 guisp=#c2bfa5 gui=NONE ctermfg=234 ctermbg=187 cterm=NONE
hi Search guifg=#14110e guibg=#bfd661 guisp=#bfd661 gui=NONE ctermfg=233 ctermbg=149 cterm=NONE
hi Delimiter guifg=#ffdead guibg=NONE guisp=NONE gui=NONE ctermfg=223 ctermbg=NONE cterm=NONE
hi Statement guifg=#ff4400 guibg=NONE guisp=NONE gui=NONE ctermfg=202 ctermbg=NONE cterm=NONE
hi Comment guifg=#07327d guibg=NONE guisp=NONE gui=NONE ctermfg=6 ctermbg=NONE cterm=NONE
hi Character guifg=#ffa0a0 guibg=NONE guisp=NONE gui=NONE ctermfg=217 ctermbg=NONE cterm=NONE
hi Number guifg=#bbd661 guibg=NONE guisp=NONE gui=NONE ctermfg=149 ctermbg=NONE cterm=NONE
hi Boolean guifg=#edae0e guibg=NONE guisp=NONE gui=NONE ctermfg=214 ctermbg=NONE cterm=NONE
hi Operator guifg=#d6d079 guibg=NONE guisp=NONE gui=NONE ctermfg=186 ctermbg=NONE cterm=NONE
hi Question guifg=#0ee839 guibg=#0f0d0f guisp=#0f0d0f gui=NONE ctermfg=40 ctermbg=233 cterm=NONE
hi WarningMsg guifg=#ff8274 guibg=NONE guisp=NONE gui=NONE ctermfg=210 ctermbg=NONE cterm=NONE
hi VisualNOS guifg=NONE guibg=NONE guisp=NONE gui=underline ctermfg=NONE ctermbg=NONE cterm=underline
hi DiffDelete guifg=#06060f guibg=#5d7373 guisp=#5d7373 gui=NONE ctermfg=233 ctermbg=66 cterm=NONE
hi ModeMsg guifg=#f4b923 guibg=NONE guisp=NONE gui=NONE ctermfg=214 ctermbg=NONE cterm=NONE
hi Define guifg=#e76767 guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE
hi Function guifg=#9aff9a guibg=NONE guisp=NONE gui=NONE ctermfg=120 ctermbg=NONE cterm=NONE
hi FoldColumn guifg=#ecca9d guibg=#4d4d4d guisp=#4d4d4d gui=NONE ctermfg=223 ctermbg=239 cterm=NONE
hi PreProc guifg=#a958db guibg=NONE guisp=NONE gui=NONE ctermfg=134 ctermbg=NONE cterm=NONE
hi Visual guifg=#fff495 guibg=#6b8e23 guisp=#6b8e23 gui=NONE ctermfg=228 ctermbg=64 cterm=NONE
hi MoreMsg guifg=#36a466 guibg=NONE guisp=NONE gui=NONE ctermfg=72 ctermbg=NONE cterm=NONE
hi VertSplit guifg=#999999 guibg=#c2bfa5 guisp=#c2bfa5 gui=NONE ctermfg=246 ctermbg=187 cterm=NONE
hi Exception guifg=#d6d079 guibg=NONE guisp=NONE gui=NONE ctermfg=186 ctermbg=NONE cterm=NONE
hi Keyword guifg=#e67717 guibg=NONE guisp=NONE gui=NONE ctermfg=166 ctermbg=NONE cterm=NONE
hi Type guifg=#0ba603 guibg=NONE guisp=NONE gui=NONE ctermfg=34 ctermbg=NONE cterm=NONE
hi DiffChange guifg=#ffffff guibg=#9761d6 guisp=#9761d6 gui=NONE ctermfg=15 ctermbg=98 cterm=NONE
hi Cursor guifg=#1a4066 guibg=#f0e68c guisp=#f0e68c gui=NONE ctermfg=17 ctermbg=228 cterm=NONE
hi Error guifg=#dadada guibg=#c00000 guisp=#c00000 gui=NONE ctermfg=253 ctermbg=1 cterm=NONE
hi PMenu guifg=#041a13 guibg=#bf9d64 guisp=#bf9d64 gui=NONE ctermfg=23 ctermbg=137 cterm=NONE
hi SpecialKey guifg=#ade738 guibg=NONE guisp=NONE gui=NONE ctermfg=149 ctermbg=NONE cterm=NONE
hi Constant guifg=#fa0d0d guibg=NONE guisp=NONE gui=NONE ctermfg=196 ctermbg=NONE cterm=NONE
hi Tag guifg=#ffdead guibg=NONE guisp=NONE gui=NONE ctermfg=223 ctermbg=NONE cterm=NONE
hi String guifg=#d67600 guibg=NONE guisp=NONE gui=NONE ctermfg=172 ctermbg=NONE cterm=NONE
hi PMenuThumb guifg=NONE guibg=#6c6c6c guisp=#6c6c6c gui=NONE ctermfg=NONE ctermbg=242 cterm=NONE
hi Repeat guifg=#d6d079 guibg=NONE guisp=NONE gui=NONE ctermfg=186 ctermbg=NONE cterm=NONE
hi CTagsClass guifg=#ced7db guibg=NONE guisp=NONE gui=NONE ctermfg=152 ctermbg=NONE cterm=NONE
hi Directory guifg=#03ab8f guibg=NONE guisp=NONE gui=NONE ctermfg=36 ctermbg=NONE cterm=NONE
hi Structure guifg=#d6d079 guibg=NONE guisp=NONE gui=NONE ctermfg=186 ctermbg=NONE cterm=NONE
hi Macro guifg=#e76767 guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE
hi Underlined guifg=#da00da guibg=NONE guisp=NONE gui=underline ctermfg=164 ctermbg=NONE cterm=underline
hi DiffAdd guifg=#f0ddf0 guibg=#3e3ebd guisp=#3e3ebd gui=NONE ctermfg=255 ctermbg=61 cterm=NONE
