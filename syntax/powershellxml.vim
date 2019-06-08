" Vim syntax file
" Language:           Windows PowerShell
" Maintainer:         Peter Provost <peter@provost.org>
" Updated:            Jesse Harris <jesse@zigford.org>
" Version:            3.00
" Project Repository: https://github.com/zigford/vim-powershell
" Vim Script Page:    TBA
"

" Compatible VIM syntax file start
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

let s:ps1xml_cpo_save = &cpo
set cpo&vim

doau syntax xml
unlet b:current_syntax

syn case ignore
syn include @ps1xmlScriptBlock <sfile>:p:h/powershell.vim
unlet b:current_syntax

syn region ps1xmlScriptBlock
      \ matchgroup=xmlTag     start="<Script>"
      \ matchgroup=xmlEndTag  end="</Script>"
      \ fold
      \ contains=@ps1xmlScriptBlock
      \ keepend
syn region ps1xmlScriptBlock
      \ matchgroup=xmlTag     start="<ScriptBlock>"
      \ matchgroup=xmlEndTag  end="</ScriptBlock>"
      \ fold
      \ contains=@ps1xmlScriptBlock
      \ keepend
syn region ps1xmlScriptBlock
      \ matchgroup=xmlTag     start="<GetScriptBlock>"
      \ matchgroup=xmlEndTag  end="</GetScriptBlock>"
      \ fold
      \ contains=@ps1xmlScriptBlock
      \ keepend
syn region ps1xmlScriptBlock
      \ matchgroup=xmlTag     start="<SetScriptBlock>"
      \ matchgroup=xmlEndTag  end="</SetScriptBlock>"
      \ fold
      \ contains=@ps1xmlScriptBlock
      \ keepend

syn cluster xmlRegionHook add=ps1xmlScriptBlock

let b:current_syntax = "powershellxml"

let &cpo = s:ps1xml_cpo_save
unlet s:ps1xml_cpo_save

