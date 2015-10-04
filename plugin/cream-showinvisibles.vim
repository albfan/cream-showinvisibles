
if !exists("g:creamInvisibleShortCut")
   let g:creamInvisibleShortCut = "<F4>"
endif

" don't load mappings or autocmd if used with Cream (elsewhere)
if !exists("$CREAM")

   " mappings
   exec "imap <silent> " . g:creamInvisibleShortCut . " <C-o>:call Cream_list_toggle(\"i\")<cr>"
   exec "vmap <silent> " . g:creamInvisibleShortCut . " :<C-u>call Cream_list_toggle(\"v\")<cr>"
   exec "nmap <silent> " . g:creamInvisibleShortCut . " :call Cream_list_toggle(\"n\")<cr>"

   " initialize on Buffer enter/new
   autocmd BufNewFile,BufEnter * call Cream_list_init()

endif


" initialize characters used to represent invisibles (global)
function! Cream_listchars_init()
   " Sets &listchars to sophisticated extended characters as possible.
   " Gracefully falls back to 7-bit ASCII per character if one is not
   " printable.
   "
   " WARNING:
   " Do not try to enter multi-byte characters below, use decimal
   " abstractions only! It's the only way to guarantee that all encodings
   " can edit this file.

   set listchars=

   " tab
   if     strlen(substitute(strtrans(nr2char(187)), ".", "x", "g")) == 1
      " right angle quote, guillemotright followed by space (digraph >>)
      execute "set listchars+=tab:" . nr2char(187) . '-'
   else
      " greaterthan, followed by space
      execute "set listchars+=tab:" . nr2char(62) . '-'
   endif

   " eol
   if     strlen(substitute(strtrans(nr2char(182)), ".", "x", "g")) == 1
      " paragrah symbol (digraph PI)
      execute "set listchars+=eol:" . nr2char(182)
   else
      " dollar sign
      execute "set listchars+=eol:" . nr2char(36)
   endif

   " trail
   if     strlen(substitute(strtrans(nr2char(183)), ".", "x", "g")) == 1
      " others digraphs: 0U 0M/M0 sB .M 0m/m0 RO
      " middle dot (digraph .M)
      execute "set listchars+=trail:" . nr2char(183)
   else
      " period
      execute "set listchars+=trail:" . nr2char(46)
   endif

   " precedes
   if !has("gui_running") && &termencoding != "utf-8"
      "elseif Cream_has("ms") && &encoding == "utf-8"
      " underscore
      execute "set listchars+=precedes:" . nr2char(95)
   elseif     strlen(substitute(strtrans(nr2char(133)), ".", "x", "g")) == 1
      " ellipses
      execute "set listchars+=precedes:" . nr2char(133)
   elseif strlen(substitute(strtrans(nr2char(8230)), ".", "x", "g")) == 1
      " ellipses (2nd try)
      execute "set listchars+=precedes:" . nr2char(8230)
   elseif strlen(substitute(strtrans(nr2char(8249)), ".", "x", "g")) == 1
            \&& v:lang != "C"
      " mathematical lessthan (digraph <1)
      execute "set listchars+=precedes:" . nr2char(8249)
   elseif strlen(substitute(strtrans(nr2char(8592)), ".", "x", "g")) == 1
      " left arrow  (digraph <-)
      execute "set listchars+=precedes:" . nr2char(8592)
   else
      " underscore
      execute "set listchars+=precedes:" . nr2char(95)
   endif

   " extends
   if !has("gui_running") && &termencoding != "utf-8"
      "elseif Cream_has("ms") && &encoding == "utf-8"
      " underscore
      execute "set listchars+=extends:" . nr2char(95)
   elseif     strlen(substitute(strtrans(nr2char(133)), ".", "x", "g")) == 1
      " ellipses
      execute "set listchars+=extends:" . nr2char(133)
   elseif strlen(substitute(strtrans(nr2char(8230)), ".", "x", "g")) == 1
      " ellipses (2nd try)
      execute "set listchars+=extends:" . nr2char(8230)
   elseif strlen(substitute(strtrans(nr2char(8250)), ".", "x", "g")) == 1
            \&& v:lang != "C"
      " mathematical greaterthan (digraph >1)
      execute "set listchars+=extends:" . nr2char(8250)
   elseif strlen(substitute(strtrans(nr2char(8594)), ".", "x", "g")) == 1
      " right arrow (digraph ->)
      execute "set listchars+=extends:" . nr2char(8594)
   else
      " underscore
      execute "set listchars+=extends:" . nr2char(95)
   endif


   if &encoding == "latin1"
      " decimal 187 followed by a space (032)
      execute "set listchars+=tab:" . nr2char(187) . '-'
      " decimal 182
      execute "set listchars+=eol:" . nr2char(182)
      " decimal 183
      execute "set listchars+=trail:" . nr2char(183)
      " decimal 133 (ellipses Â)
      execute "set listchars+=precedes:" . nr2char(133)
      execute "set listchars+=extends:" . nr2char(133)

      " patch 6.1.469 fixes list with multi-byte chars! (2003-04-16)
   elseif &encoding == "utf-8" && v:version >=602
            \|| &encoding == "utf-8" && v:version == 601 && has("patch469")
      " decimal 187 followed by a space (032)
      execute "set listchars+=tab:" . nr2char(187) . '-'
      " decimal 182
      execute "set listchars+=eol:" . nr2char(182)
      " decimal 9642 (digraph sB âª )
      " decimal 9675 (digraph m0 â )
      " decimal 9679 (digraph M0 â )
      " decimal 183
      execute "set listchars+=trail:" . nr2char(183)
      " decimal 8222 (digraph :9 â )
      " decimal 8249 (digraph <1 â¹ )
      execute "set listchars+=precedes:" . nr2char(8249)
      " decimal 8250 (digraph >1 âº )
      execute "set listchars+=extends:" . nr2char(8250)
      execute "set listchars+=space:" . nr2char(183)

   else
      set listchars+=tab:>-		" decimal 62 followed by a space (032)
      set listchars+=eol:$		" decimal 36
      set listchars+=trail:.		" decimal 46
      set listchars+=precedes:_	" decimal 95
      set listchars+=space:·	" decimal 95
      set listchars+=extends:_	" decimal 95
   endif

endfunction
call Cream_listchars_init()

" initialize environment on BufEnter (local)
function! Cream_list_init()
   if !exists("g:LIST")
      " initially off
      set nolist
      let g:LIST = 0
   else
      if g:LIST == 1
         set list
      else
         set nolist
      endif
   endif
endfunction

" toggle on/off
function! Cream_list_toggle(mode)
   if exists("g:LIST")
      if g:LIST == 0
         set list
         let g:LIST = 1
      elseif g:LIST == 1
         set nolist
         let g:LIST = 0
      endif
   else
      call confirm(
               \"Error: global uninitialized in Cream_list_toggle()", "&Ok", 1, "Error")
   endif
   if a:mode == "v"
      normal gv
   endif
endfunction

" vim:fileencoding=utf-8
