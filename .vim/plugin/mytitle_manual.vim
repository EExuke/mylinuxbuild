" ============================================================================
" Copyright (C) 2001-2020 Inhand Networks, Inc.
" ============================================================================

" ----------------------------------------------------------------------------
" ============================================================================
"    Filename                 : mytitle_manual.vim
"    Version                  : 1.0
"    Author                   : Zhendong Cao
"    Last Change              : 2018/11/29
"    Description              : This program is free software.
" ============================================================================

" General format {{{1
if exists('LOADED_MYTITLE_MANUAL_VIM')
    finish
endif

if v:version < 700
    echoerr "MYTITLE_MANUAL: this plugin requires vim >= 7!"
    finish
endif

let LOADED_MYTITLE_MANUAL_VIM=1

" Line continuation used here
let s:cpo_save = &cpo
set cpo&vim

" AddTitle {{{1
func AddTitle()
    if &filetype == 'sh'
        call append(0,"############################################################################# ##")
        call append(1, " # Copyright (C) 2001-2020 Inhand Networks, Inc.")
        call append(2, "\ ############################################################################ ##")
        call append(3, " #")
        call append(4, " # -------------------------------------------------------------------------- --")
        call append(5, " #     AUTHOR                   : xuke")
        call append(6, " #     FILE NAME                : ".expand('%:t'))
        call append(7, " #     FILE DESCRIPTION         : Linux shell script file")
        call append(8, " #     FIRST CREATION DATE      : ".strftime("%Y/%m/%d"))
        call append(9, " # --------------------------------------------------------------------------")
        call append(10, " #     Version                  : 1.0")
        call append(11, " #     Last Change              : ".strftime("%Y/%m/%d"))
        call append(12, "\## ************************************************************************** ##")
    elseif expand("%:e") == 'py'
        call append(0, "\############################################################################# ##")
        call append(1, "\# Copyright (C) 2019-2020 Inhand Networks, Inc.")
        call append(2, "\############################################################################# ##")
        call append(3, "\#")
        call append(4, "# --------------------------------------------------------------------------")
        call append(5, "#     AUTHOR                   : EExuke")
        call append(6, "#     FILE NAME                : ".expand('<afile>:t'))
        call append(7, "#     FILE DESCRIPTION         : Python file")
        call append(8, "#     FIRST CREATION DATE      : ".strftime("%Y/%m/%d"))
        call append(9, "# --------------------------------------------------------------------------")
        call append(10, "#     Version                  : 1.0")
        call append(11, "#     Last Change              : ".strftime("%Y/%m/%d"))
        call append(12, "## ************************************************************************** ##")
        call append(13, "")
        call append(14, "\#-----------------------------------------------------------")
        call append(15, "\#                  MAIN PROCESS")
        call append(16, "\#-----------------------------------------------------------")
        call cursor(17, "")
    elseif expand("%:e") == 'vim'
        call append(0, "\" ============================================================================")
        call append(1, "\" Copyright (C) 2001-2020 Inhand Networks, Inc.")
        call append(2, "\" ============================================================================")
        call append(3, "")
        call append(4, "\" ----------------------------------------------------------------------------")
        call append(5, "\" ============================================================================")
        call append(6, "\"    AUTHOR                   : xuke")
        call append(7, "\"    FILE NAME                : ".expand('%:t'))
        call append(8, "\"    DESCRIPTION              : This program is free software.")
        call append(9, "\"    FIRST CREATION DATE      : ".strftime("%Y/%m/%d"))
        call append(10, "\" ----------------------------------------------------------------------------")
        call append(11, "\"    Version                  : 1.0")
        call append(12, "\"    Last Change              : ".strftime("%Y/%m/%d"))
        call append(13, "\" ============================================================================")
    elseif &filetype == 'c' || expand("%:e") == 'h'
        call append(0,"/**************************************************************************** **")
        call append(1, " * Copyright (C) 2001-2020 Inhand Networks, Inc.")
        call append(2, " **************************************************************************** **/")
        call append(3, "")
        call append(4, "\/* ************************************************************************** **")
        call append(5, " *     MODULE NAME            : system")
        call append(6, " *     LANGUAGE               : C")
        call append(7, " *     TARGET ENVIRONMENT     : Any")
        call append(8, " *     FILE NAME              : ".expand('%:t'))
        call append(9, " *     FIRST CREATION DATE    : ".strftime("%Y/%m/%d"))
        call append(10, " * --------------------------------------------------------------------------")
        call append(11, " *     Version                : 1.0")
        call append(12, " *     Author                 : xuke")
        call append(13, " *     Last Change            : ".strftime("%Y/%m/%d"))
        if &filetype == 'c'
            call append(14, " *     FILE DESCRIPTION       :")
            call append(15, "** ************************************************************************** */")
        elseif expand("%:e") == 'h'
            call append(14, " *     FILE DESCRIPTION       : API exported to external moduels")
            call append(15, "** ************************************************************************** */")
        endif
    else
        if expand("%:e") == ''
            if expand("%:r") == ''
                echohl WarningMsg | echo "No Support AddTitle for (null name files) yet!!!" | echohl None
            else
                echohl WarningMsg | echo "No Support AddTitle for ".expand('%:r')"yet!!!" | echohl None
            endif
        else
            echohl WarningMsg | echo "No Support AddTitle for (name).".expand("%:e")"files yet!!!" | echohl None
        endif
    endif
endfunc

" TitleDet {{{1
function TitleDet()
    let n=1
    while n < 20
        let line = getline(n)

        if &filetype == 'c' || expand("%:e") == 'h'
            if line =~ '^\s*\*\s*\S*Last\s*Change\s*:\s*\S*.*$'
                call UpdateTitle()
                return
            endif
        elseif expand("%:e") == 'vim'
            if line =~ '^\"\s*\S*Last\s*Change\s*:\s*\S*.*$'
                call UpdateTitle()
                return
            endif
        elseif &filetype == 'sh'
            if line =~ '^\s*\#\s*\S*Last\s*Change\s*:\s*\S*.*$'
                call UpdateTitle()
                return
            endif
        endif

        let n = n + 1
    endwhile

    call AddTitle()

endfunc

" UpdateTitle {{{1
func UpdateTitle()
    normal m'
    execute '/Last\s*Change/s@:.*$@\=strftime(": %Y/%m/%d")@'
    normal ''
    normal mk
    execute '/FILE\s*NAME/s@:.*$@\=": ".expand("%:t")@'
    execute "noh"
    normal 'k
    echohl WarningMsg | echo "Successful in updating the title !!!" | echohl None
endfunc

" General format end {{{1
" restore 'cpo'
let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set foldenable foldmethod=marker:
