" vim:foldmethod=marker
" =============================================================================
" File:         TagmaLast.vim (Plugin)
" Last Changed: Fri Feb 17 12:22 PM 2012 EST
" Maintainer:   Lorance Stinson AT Gmail...
" License:      Public Domain
"
" Description:  Updates the 'Last Changed' line of a file.
"
"               If g:TagmaLastUseUndoJoin is set :undojoin is used to make the
"               change more transparent. This means the change to the 'Last
"               Changed' line is combined with the previous change so :undo
"               undoes both changes.
"
"               The pattern used to search for the 'Last Changed' line is
"               searched for using the regexp in g:TagmaLastSearchRegexp.
" =============================================================================

" Only load once {{{1
if exists('g:TagmaLastloaded') || &cp || !exists("*strftime")
    finish
endif
let g:TagmaLastloaded= 1

" Defaults: {{{1
function! s:SetDefault(option, default)
    if !exists(a:option)
        execute 'let ' . a:option . '=' . string(a:default)
    endif
endfunction

" Automatically update the last change for all writes.
call s:SetDefault('g:TagmaLastAutoUpdate',      0)

" The number of lines to check for a 'Last Changed' line.
call s:SetDefault('g:TagmaLastCheckLines',      20)

" The key mapping to use for manual updates.
" Set to an empty string to disable the key mapping.
" If a keymap to <Plug>UpdateLast already exists this is ignored.
call s:SetDefault('g:TagmaLastKeyMap',          '<Leader>UL')

" The time format. See ':help strftime' for details.
call s:SetDefault('g:TagmaLastTimeFormat',      '%a %b %d %I:%M %p %Y %Z')

" The regular expression to search for the 'Last Changed' line.
call s:SetDefault('g:TagmaLastSearchRegexp',    'Last\s\+\%(Changed\|Modified\):\s\+')

" Join the change to the 'Last Change' line with the previous change when
" performing an auto update on write.
" This makes :undo undo both changes.
call s:SetDefault('g:TagmaLastUseUndoJoin',     0)

" No need for the function any longer.
delfunction s:SetDefault

" Internal Settings: {{{1

" Detect if the timezone format is broken.
let g:TagmaLastBrokenTZ = strftime('%Z') =~ '\s'

" User Commands: {{{1

" Disable auto updates.
command! -nargs=0 TagmaLastDisable call s:AutoupdateDisable()

" Enable auto updates.
command! -nargs=0 TagmaLastEnable call s:AutoupdateEnable()

" Update the 'Last Changed' line.
command! -nargs=0 UpdateLast call s:UpdateLastChanged()

" Plugin Mapping: {{{1
noremap <unique> <script> <Plug>UpdateLast :call <SID>UpdateLastChanged()<CR>

" Global Key Mapping: {{{1
if g:TagmaLastKeyMap != '' && !hasmapto('<Plug>UpdateLast')
    execute 'map <silent> <unique> ' . g:TagmaLastKeyMap . ' <Plug>UpdateLast'
endif

" Automatic Updates: {{{1
if g:TagmaLastAutoUpdate
    autocmd VimEnter * call s:AutoupdateEnable()
endif

" Function: s:AutoupdateDisable -- Disable automatic updates on write. {{{1
"   Deletes the BufWritePre autocommand.
"
" Arguments:
"   None
"
" Result:
"   None
"
" Side effect:
"   The autocommand for the BufWritePre event is deleted.
function! s:AutoupdateDisable()
    augroup TagmaUpdate
        autocmd!
    augroup END
endfunction

" Function: s:AutoupdateEnable -- Enable automatic updates on write. {{{1
"   Creates the BufWritePre autocommand.
"
" Arguments:
"   None
"
" Result:
"   None
"
" Side effect:
"   The autocommand for the BufWritePre event is created.
function! s:AutoupdateEnable()
    augroup TagmaUpdate
        autocmd BufWritePre * call s:UpdateLastChanged()
    augroup END
endfunction

" Function: s:UpdateLastChanged -- Update the 'Last Changed' line. {{{1
"   Locates and updated the 'Last Changed' line of a file.
"
" Arguments:
"   None
"
" Result:
"   None
"
" Side effect:
"   The 'Last Changed' line of the file is updated.
"   The update is joined to the previous change using :undojoin.
function! s:UpdateLastChanged()
    " If the time format contains %Z and the timezone is not the standard
    " three character version then adjust the time format.
    " This is an issue primarily on Windows.
    let l:time_format = g:TagmaLastTimeFormat
    if l:time_format =~ '%Z' && g:TagmaLastBrokenTZ
        let l:time_zone = substitute(strftime('%Z'), '\(\w\)\w\+\s*', '\1', 'g')
        let l:time_format = substitute(l:time_format, '%Z', l:time_zone, '')
    endif

    " Search for the 'Last Changed' line.
    let l:lnum = 0
    let l:replace = '\(' . g:TagmaLastSearchRegexp . '\).*$'
    while l:lnum < g:TagmaLastCheckLines
        let l:line = getline(l:lnum)
        if l:line =~ g:TagmaLastSearchRegexp
            " Found the line. Perform the replacement.
            let l:timestamp = strftime(l:time_format)
            let l:line = substitute(l:line, l:replace, '\1' . l:timestamp, 'g')
            if g:TagmaLastUseUndoJoin
                silent! undojoin | call setline(l:lnum, l:line)
            else
                call setline(l:lnum, l:line)
            endif
            break
        endif
        let l:lnum += 1
    endwhile
endfunction
