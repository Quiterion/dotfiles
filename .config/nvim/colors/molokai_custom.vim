" Vim color file
"
" Author: Tomas Restrepo <tomas@winterdom.com>
" https://github.com/tomasr/molokai
"
" Note: Based on the Monokai theme for TextMate
" by Wimer Hazenberg and its darker variant
" by Hamish Stuart Macpherson
"

hi clear
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="molokai_custom"

if exists("g:molokai_original")
    let s:molokai_original = g:molokai_original
else
    let s:molokai_original = 0
endif

"
" Support for 256-color terminal
"
if &t_Co > 255
    "hi Normal                   ctermbg=234
    hi Normal                   ctermbg=none
    hi CursorLine               ctermbg=none cterm=none
    "hi CursorLineNr ctermfg=208             cterm=none
    hi CursorLineNr    ctermfg=242             cterm=none
    hi Boolean         ctermfg=135
    hi Character       ctermfg=144
    hi Number          ctermfg=135
    hi String          ctermfg=144
    hi Conditional     ctermfg=161             cterm=bold
    hi Constant        ctermfg=135             cterm=bold
    hi Cursor          ctermfg=16  ctermbg=253
    hi Debug           ctermfg=225             cterm=bold
    hi Define          ctermfg=81
    hi Delimiter       ctermfg=241

    hi DiffAdd                     ctermbg=24
    hi DiffChange      ctermfg=181 ctermbg=239
    hi DiffDelete      ctermfg=162 ctermbg=53
    hi DiffText                    ctermbg=102 cterm=bold

    hi Directory       ctermfg=118             cterm=bold
    hi Error           ctermfg=219 ctermbg=89
    hi ErrorMsg        ctermfg=199 ctermbg=16  cterm=bold
    hi Exception       ctermfg=118             cterm=bold
    hi Float           ctermfg=135
    hi Folded          ctermfg=15  ctermbg=233
    hi FoldColumn      ctermfg=15  ctermbg=233
    hi Function        ctermfg=118
    hi Identifier      ctermfg=208             cterm=none
    hi Ignore          ctermfg=244 ctermbg=232
    hi IncSearch       ctermfg=193 ctermbg=16

    hi keyword         ctermfg=161             cterm=bold
    hi Label           ctermfg=229             cterm=none
    hi Macro           ctermfg=193
    hi SpecialKey      ctermfg=81

    hi MatchParen                  ctermbg=none cterm=underline
    hi ModeMsg         ctermfg=229
    hi MoreMsg         ctermfg=229
    hi Operator        ctermfg=161

    " complete menu
    hi Pmenu           ctermfg=81  ctermbg=233
    hi PmenuSel        ctermfg=255 ctermbg=242
    hi PmenuSbar                   ctermbg=232
    hi PmenuThumb      ctermfg=81

    hi PreCondit       ctermfg=118             cterm=bold
    hi PreProc         ctermfg=118
    hi Question        ctermfg=81
    hi Repeat          ctermfg=161             cterm=bold
    hi Search          ctermfg=0   ctermbg=222 cterm=none

    " marks column
    hi SignColumn      ctermfg=237 ctermbg=none cterm=strikethrough,bold
    hi SpecialChar     ctermfg=161             cterm=bold
    hi SpecialComment  ctermfg=245             cterm=bold
    hi Special         ctermfg=81
    if has("spell")
        hi SpellBad                ctermbg=52
        hi SpellCap                ctermbg=17
        hi SpellLocal              ctermbg=17
        hi SpellRare   ctermfg=none ctermbg=none cterm=reverse
    endif
    hi Statement       ctermfg=161             cterm=bold
    hi StatusLine                                cterm=none
    "hi StatusLineNC    ctermfg=244 ctermbg=232
    hi StorageClass    ctermfg=208
    hi Structure       ctermfg=81
    hi Tag             ctermfg=161
    hi Title           ctermfg=166
    hi Todo            ctermfg=231 ctermbg=232 cterm=bold

    hi Typedef         ctermfg=81
    hi Type            ctermfg=81              cterm=none
    hi Underlined      ctermfg=244             cterm=underline

    hi VertSplit       ctermfg=255
    hi Visual          ctermfg=16   ctermbg=247 cterm=none
    hi WarningMsg      ctermfg=231 ctermbg=238  cterm=bold
    hi WildMenu                                 cterm=bold

    hi Comment         ctermfg=248
    hi CursorColumn                ctermbg=236
    hi ColorColumn                 ctermbg=236
    hi LineNr          ctermfg=242 ctermbg=none
    hi NonText         ctermfg=59

    hi SpecialKey      ctermfg=59
    " Coc
    hi CocErrorSign    ctermfg=196   cterm=bold
    hi CocWarningSign  ctermfg=208   cterm=bold
    hi CocHintSign     ctermfg=59    cterm=italic
    end

    " Must be at the end, because of ctermbg=234 bug.
    " https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
    set background=dark
