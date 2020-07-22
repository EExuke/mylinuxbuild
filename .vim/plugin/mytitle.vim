" ============================================================================
" Copyright (C) 2001-2020 Inhand Networks, Inc.
" ============================================================================

" ----------------------------------------------------------------------------
" ============================================================================
"    Filename                 : mytitle.vim
"    Version                  : 1.0
"    Author                   : EExuke
"    Last Change              : 2019/7/1 by EExuke
"    Description              : This program is free software.
" ============================================================================

" General Format {{{1
if exists('loaded_mytitle')
    finish
endif

if v:version < 700
    echoerr "LOAD_MYTILE: this plugin requires vim >= 7. DOWNLOAD IT! You'll thank me later!"
    finish
endif

let loaded_mytitle=1

" Line continuation used here
let s:cpo_save = &cpo
set cpo&vim

" COMMON TITILE with lisence {{{1
func SetCopyright()
    if &filetype == 'sh'
        call append(0, "\ ############################################################################# ##")
        call append(1, "\ # Copyright (C) 2001-2020 Inhand Networks, Inc.")
        call append(2, "\ ############################################################################ ##")
        call append(3, "\ #")
    elseif expand("%:e") == 'py'
        call append(0, "\############################################################################# ##")
        call append(1, "\# Copyright (C) 2001-2020 Inhand Networks, Inc.")
        call append(2, "\############################################################################# ##")
        call append(3, "\#")
    elseif expand("%:e") == 'vim'
        call append(0, "\" ============================================================================")
        call append(1, "\" Copyright (C) 2001-2020 Inhand Networks, Inc.")
        call append(2, "\" ============================================================================")
        call append(3, "")
    elseif expand("%:t") == 'Makefile'
        call append(0, "\# ==========================================")
        call append(1, "\# © 2020 EExuke. All Rights Reserved.")
        call append(2, "\# ==========================================")
        call append(3, "")
    else
        call append(0,"/**************************************************************************** **")
        call append(1, " * Copyright (C) 2001-2020 Inhand Networks, Inc.")
        call append(2, " **************************************************************************** **/")
        call append(3, "")
    endif
endfunc
" AutoSetTitle {{{1
func AutoSetTitle()
    " Refer : https://www.cnblogs.com/syntax/archive/2013/04/06/3002052.html
    call SetCopyright()

    if &filetype == 'sh'
        call SetShellTitle()
    elseif expand("%:e") == 'h'
        call SetHTitle()
    elseif expand("%:e") == 'py'
        call SetPythonTitle()
    elseif expand("%:t") == 'Makefile'
        call SetMKTitle()
    elseif expand("%:e") == 'vim'
        call SetVimTitle()
    endif
    if &filetype == 'c'
        call SetCTitle()
    endif
endfunc

" SH-FILE TITILE {{{1
func SetShellTitle()
    let i=4
    call append(i, " # -------------------------------------------------------------------------- --")
    call append(i+1, " #     AUTHOR                   : EExuke")
    call append(i+2, " #     FILE NAME                : ".expand('<afile>:t'))
    call append(i+3, " #     FILE DESCRIPTION         : Linux shell script file")
    call append(i+4, " #     FIRST CREATION DATE      : ".strftime("%Y/%m/%d"))
    call append(i+5, " # --------------------------------------------------------------------------")
    call append(i+6, " #     Version                  : 1.0")
    call append(i+7, " #     Last Change              : ".strftime("%Y/%m/%d"))
    call append(i+8, " ## ************************************************************************** ##")
    call append(i+9, "\#!/bin/bash")
    call append(i+10, "\#-----------------------------------------------------------")
    call append(i+11, "\#                COLOUR VARIABLES")
    call append(i+12, "\#-----------------------------------------------------------")
    call append(i+13, "UNDL=\"\\033\[4m\"    F6_E=\"\\033\[0m\"    B_WT=\"\\033\[47m\"")
    call append(i+14, "F_BL=\"\\033\[30m\"   F_RD=\"\\033\[31m\"   F_GR=\"\\033\[32m\"")
    call append(i+15, "F_YL=\"\\033\[33m\"   F_BU=\"\\033\[34m\"   F_PU=\"\\033\[35m\"")
    call append(i+16, "F_DG=\"\\033\[36m\"   F_WT=\"\\033\[37m\"   B_BL=\"\\033\[40m\"")
    call append(i+17, "B_RE=\"\\033\[41m\"   B_GR=\"\\033\[42m\"   B_YL=\"\\033\[43m\"")
    call append(i+18, "B_BU=\"\\033\[44m\"   B_PR=\"\\033\[45m\"   B_DG=\"\\033\[46m\"")
    call append(i+19, "")
    call append(i+20, "\#-----------------------------------------------------------")
    call append(i+21, "\#                  MAIN PROCESS")
    call append(i+22, "\#-----------------------------------------------------------")
    call cursor(i+23,0)
endfunc
" C&H common TITILE {{{1
func SetCHComTitle()
    let i=4
    call append(i, "\/* ************************************************************************** **")
    call append(i+1, " *     MODULE NAME            : system")
    call append(i+2, " *     LANGUAGE               : C")
    call append(i+3, " *     TARGET ENVIRONMENT     : Any")
    call append(i+4, " *     FILE NAME              : ".expand('<afile>:t'))
    call append(i+5, " *     FIRST CREATION DATE    : ".strftime("%Y/%m/%d"))
    call append(i+6, " * --------------------------------------------------------------------------")
    call append(i+7, " *     Version                : 1.0")
    call append(i+8, " *     Author                 : EExuke")
    call append(i+9, " *     Last Change            : ".strftime("%Y/%m/%d"))
endfunc
" C-FILE TITILE {{{1
func SetCTitle()
    let i=4
    call SetCHComTitle()
    call append(i+10, " *     FILE DESCRIPTION       :")
    call append(i+11, "** ************************************************************************** */")
    "call append(i+12, "#ifndef _".toupper(expand("%:t:r"))."_C_")
    "call append(i+13, "#define _".toupper(expand("%:t:r"))."_C_")
    call append(i+12, "")
    call append(i+13, "#include <stdio.h>")
    call append(i+14, "#include <stdlib.h>")
    call append(i+15, "")
    call append(i+16, "\/****************************************************************************")
    call append(i+17, " *  Function Name : main")
    call append(i+18, " *  Description   : The Main Function.")
    call append(i+19, " *  Input(s)      : argc - The numbers of input value.")
    call append(i+20, " *                : argv - The pointer to input specific parameters.")
    call append(i+21, " *  Output(s)     : NULL")
    call append(i+22, " *  Returns       : 0")
    call append(i+23, " ****************************************************************************/")
    call append(i+24, "int main(int argc, const char *argv[])")
    call append(i+25, "{")
    call append(i+26, "    return 0;")
    call append(i+27, "}")
    "call append(i+30, "#endif /* End of _".toupper(expand("%:t:r"))."_C_ */")
    call cursor(i+28,0)
endfunc
" H-FILE TITILE {{{1
func SetHTitle()
    let i=4
    call SetCHComTitle()
    call append(i+10, " *     FILE DESCRIPTION       : API exported to external moduels")
    call append(i+11, "** ************************************************************************** */")
    call append(i+12, "#ifndef _".toupper(expand("%:t:r"))."_H_")
    call append(i+13, "#define _".toupper(expand("%:t:r"))."_H_")
    call append(i+14, "")
    call append(i+15, "\/*------------------Macro Definition-------------------------*/")
    call append(i+16, "\/*------------------End of Macro Definition------------------*/")
    call append(i+17, "")
    call append(i+18, "\/*------------------API Definition---------------------------*/")
    call append(i+19, "\/*------------------End of API Definition--------------------*/")
    call append(i+20, "")
    call append(i+21, "#endif /* End of _".toupper(expand("%:t:r"))."_H_ */")
    call cursor(i+16,0)
endfunc

" Makefile TITILE {{{1
func SetMKTitle()
    let i=3
    call append(i+1, "DIR_OBJ = ./obj")
    call append(i+2, "DIR_SRC = ./src")
    call append(i+3, "INC_SRC = ./inc")
    call append(i+4, "")
    call append(i+5, "SRC = $(wildcard ${DIR_SRC}/*.c)")
    call append(i+6, "OBJ = $(patsubst %.c, ${DIR_OBJ}/%.o, $(notdir $(SRC)))")
    call append(i+7, "")
    call append(i+8, "BIN_TARGET = ")
    call append(i+9, "")
    call append(i+10, "CC = gcc")
    call append(i+11, "CFLAGS = -g -Wall -I $(INC_SRC)")
    call append(i+12, "${BIN_TARGET}: ${OBJ}")
    call append(i+13, "	$(warning Building $(BIN_TARGET) ...)")
    call append(i+14, "	@$(CC) $(OBJ) -o $@")
    call append(i+15, "")
    call append(i+16, "${DIR_OBJ}/%.o: ${DIR_SRC}/%.c")
    call append(i+17, "	$(warning Comping $< ...)")
    call append(i+18, "	@$(CC) $(CFLAGS) -c $< -o $@")
    call append(i+19, "")
    call append(i+20, "# Prevent naming conflicts such as the existence of a file named clean.")
    call append(i+21, ".PHONY: clean")
    call append(i+22, "")
    call append(i+23, "clean:")
    "call append(i+24, "	$(warning Clean $(OBJ), $(BIN_TARGET) ...)")
    call append(i+24, "	@find ${DIR_OBJ} -name *.o -exec rm -rf {} \\;")
    call append(i+25, "	@rm -rf $(BIN_TARGET)")
    call cursor(i+9,13)
endfunc
" VIM-FILE TITILE {{{1
func SetVimTitle()
    let i=4
    call append(i, "\" ----------------------------------------------------------------------------")
    call append(i+1, "\" ============================================================================")
    call append(i+2, "\"    AUTHOR                   : EExuke")
    call append(i+3, "\"    FILE NAME                : ".expand('<afile>:t'))
    call append(i+4, "\"    DESCRIPTION              : This program is free software.")
    call append(i+5, "\"    FIRST CREATION DATE      : ".strftime("%Y/%m/%d"))
    call append(i+6, "\" ----------------------------------------------------------------------------")
    call append(i+7, "\"    Version                  : 1.0")
    call append(i+8, "\"    Last Change              : ".strftime("%Y/%m/%d"))
    call append(i+9, "\" ============================================================================")
    call append(i+10, "")
    call append(i+11, "\" General format \{\{\{1")
    call append(i+12, "if exists('LOADED_".toupper(expand("%:t:r"))."_VIM')")
    call append(i+13, "    finish")
    call append(i+14, "endif")
    call append(i+15, "")
    call append(i+16, "if v:version < 700")
    call append(i+17, "    echoerr \"".toupper(expand("%:t:r")).": this plugin requires vim >= 7!\"")
    call append(i+18, "    finish")
    call append(i+19, "endif")
    call append(i+20, "")
    call append(i+21, "let LOADED_".toupper(expand("%:t:r"))."_VIM=1")
    call append(i+22, "")
    call append(i+23, "\" Line continuation used here")
    call append(i+24, "let s:cpo_save = &cpo")
    call append(i+25, "set cpo&vim")
    call append(i+26, "")
    call append(i+27, "\" \{\{\{1")
    call append(i+28, "")
    call append(i+29, "\" General format end \{\{\{1")
    call append(i+30, "\" restore 'cpo'")
    call append(i+31, "let &cpo = s:cpo_save")
    call append(i+32, "unlet s:cpo_save")
    call append(i+33, "")
    call append(i+34, "\" vim:set foldenable foldmethod=marker:")
    call cursor(i+28,1)
endfunc

" restore 'cpo'
let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set foldenable foldmethod=marker:

" Python-FILE TITILE {{{1
func SetPythonTitle()
    let i=4
    call append(i, "# --------------------------------------------------------------------------")
    call append(i+1, "#     AUTHOR                   : EExuke")
    call append(i+2, "#     FILE NAME                : ".expand('<afile>:t'))
    call append(i+3, "#     FILE DESCRIPTION         : Python file")
    call append(i+4, "#     FIRST CREATION DATE      : ".strftime("%Y/%m/%d"))
    call append(i+5, "# --------------------------------------------------------------------------")
    call append(i+6, "#     Version                  : 1.0")
    call append(i+7, "#     Last Change              : ".strftime("%Y/%m/%d"))
    call append(i+8, "## ************************************************************************** ##")
    call append(i+9, "")
    call append(i+10, "\#-----------------------------------------------------------")
    call append(i+11, "\#                  MAIN PROCESS")
    call append(i+12, "\#-----------------------------------------------------------")
    call cursor(i+13,0)
endfunc
