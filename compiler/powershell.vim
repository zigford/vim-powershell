" Vim compiler plugin file
" Language:           Windows PowerShell
" Maintainer:         Jesse Harris <jesse@zigford.org>
" Contributer:         Enno Nagel
" Version:            3.00
" Project Repository: https://github.com/zigford/vim-powershell
" Vim Script Page:    TBA
"
if exists('current_compiler') | finish | endif
    let current_compiler = 'pwsh'

if exists(':CompilerSet') != 2                " older Vim always used :setlocal
    command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

if executable('powershell')
    set makeprg=powershell\ -NoProfile\ -NoLogo\ -NonInteractive\ -command\ \"&{
        \trap{$_.tostring();continue}&{
        \[void]$executioncontext.invokecommand.invokescript('%')
        \}
    \}\"
elseif executable('pwsh')
    set makeprg=pwsh\ -NoProfile\ -NoLogo\ -NonInteractive\ -command\ \"&{
          \trap{\\$_.tostring();continue}&{
          \[void]\\$executioncontext.invokecommand.invokescript('%')
          \}
          \}\"
endif

silent CompilerSet makeprg
silent CompilerSet errorformat=%EAt\ %f:%l\ char:%c,%-C+%.%#,%Z%m,%-G\\s%#
