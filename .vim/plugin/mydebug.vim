" ============================================================================
" Copyright (C) 2010-2011 Inhand Communications, Inc.
" ============================================================================

" ----------------------------------------------------------------------------
" ============================================================================
"    Filename                 : mydebug.vim
"    Version                  : 1.0
"    Author                   : Zhendong Cao
"    Date                     : 2018/11/19
"    Description              : This program is free software.
" ============================================================================

" General Format {{{1
if exists('LOADED_MYDEBUG_VIM')
    finish
endif

if v:version < 700
    echoerr "MYDEBUG: this plugin requires vim >= 7!"
    finish
endif

let LOADED_MYDEBUG_VIM=1

" Line continuation used here
let s:cpo_save = &cpo
set cpo&vim

" {{{1
" Using printf to debug process logic inside of C program,
" you should has included my dbg.h into future/inc/iss.h first.
" support 8 colors to be debuged with message.
func ElogDebug()
	call append(line("."), "log_d(\"\");")
endfunc
func LogDebug()
	call append(line("."), "LOG_DB(\"%s(%d):\", __func__, __LINE__);")
endfunc
func PrintDebug()
	call append(line("."), "my_debug_msg(\"\");")
endfunc
func PrintDebug_red()
	call append(line("."), "my_debug_red_msg(\"\");")
endfunc
func PrintDebug_yellow()
	call append(line("."), "my_debug_yellow_msg(\"\");")
endfunc
func PrintDebug_darkgreen()
	call append(line("."), "my_debug_darkgreen_msg(\"\");")
endfunc
func PrintDebug_green()
	call append(line("."), "my_debug_green_msg(\"\");")
endfunc
func PrintDebug_blue()
	call append(line("."), "my_debug_blue_msg(\"\");")
endfunc
func PrintDebug_purple()
	call append(line("."), "my_debug_purple_msg(\"\");")
endfunc
func PrintDebug_black()
	call append(line("."), "my_debug_black_msg(\"\");")
endfunc
func PrintBreak_point()
	call append(line("."), "my_break_point(\"\");")
endfunc
func Print_Backtrace()
	call append(line("."), "my_debug_backtrace();")
endfunc
func PrintDebug_outData()
	call append(line("."), "MY_DATA_OUTPUT(\"file.csv\", \"%d,%d\\n\", );")
endfunc
func IncludeMyDebugHeader()
	call append(line(".")-1, "#include \"/home/xuke/bin/dbg.h\"")
endfunc

" Auto add the InhandTag into source code.
func PrintIssueTag()
	call append(line("."), "\/* ZklxTag: xuke modified on ".strftime("%Y/%m/%d")." for fixing M# */")
endfunc

" restore 'cpo'
let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set foldenable foldmethod=marker:
