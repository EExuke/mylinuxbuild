" ============================================================================
" Copyright (C) 2001-2020 Inhand Networks, Inc.
" ============================================================================

" ----------------------------------------------------------------------------
" ============================================================================
"    AUTHOR                   : EExuke
"    FILE NAME                : c.vim
"    DESCRIPTION              : This program is free software.
"    FIRST CREATION DATE      : 2022/04/26
" ----------------------------------------------------------------------------
"    Version                  : 1.0
"    Last Change              : 2022/04/26
" ============================================================================

" General format {{{1
if exists('LOADED_C_VIM')
    finish
endif

if v:version < 700
    echoerr "C: this plugin requires vim >= 7!"
    finish
endif

let LOADED_C_VIM=1

" Line continuation used here
let s:cpo_save = &cpo
set cpo&vim

" {{{1

" General format end {{{1
" restore 'cpo'
let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set foldenable foldmethod=marker:
source ~/.vim/syntax/ifdef.vim
