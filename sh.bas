   10  local_version$ = "6.6.5" : local_name$ = "sh"
   20  if arg$ = "--version" or arg$ = "-v" then ? local_name$ " [" ARGV$(0) "] " local_version$ : end
   30  z = 0.5 : rem refresh rate
   40  rem function definitions
   50  def fnreplace$(s$,f$,r$) = left$(s$,instr(s$,f$)) + r$ + mid$(s$,instr(s$,f$)+len(f$)+1)
   60  def fnback$(n) = chr$(27) + "[" + str$(n) + "D"
   70  def fnclearline$(s$) = chr$(27) + "[1K" + chr$(13) + s$ + chr$(27) + "[0K"
   80  def fnchomp$(s$) = left$(s$,len(s$)-2)
   90  open "mycmds.dat", as #1
  100  if typ(1) = 3 then close #1 : goto 130
  110  input# 1, mycmds$(ncmds) : ncmds = ncmds + 1
  120  goto 100
  130  ? chr$(27) + "[1G" ;
  140  o$ = user$ + "@" + left$(th_hostname$,instr(th_hostname$," ")) + " ~ $ " + sh_readline$ : ? fnclearline$(o$) ;
  150  if sh_cpos < len(sh_readline$) then ? fnback$(len(sh_readline$)-sh_cpos) ;
  160  if sh_cpos > len(sh_readline$) then sh_cpos = len(sh_readline$)
  170  if sh_lastspacepos > len(sh_readline$) then sh_lastspacepos = 0
  180  sh_readkey$ = polkey$(z)
  190  if sh_readkey$ = chr$(12) then cls : goto 140
  200  if sh_readkey$ = chr$(11) then goto 180
  210  if sh_readkey$ = chr$(32) then sh_lastspacepos = sh_cpos
  220  if sh_readkey$ = chr$(9) then goto 570 : rem autocomplete
  230  if sh_readkey$ = chr$(13) and sh_readline$ = "" then ? : goto 130
  240  if right$(sh_readline$,2) = chr$(13) + chr$(10) then sh_readline$ = left$(sh_readline$,len(sh_readline$)-1)
  250  if sh_readkey$ = chr$(13) or sh_readkey$ = chr$(10) then goto 450
  260  if sh_readkey$ = chr$(27) then goto 340
  270  if ( sh_readkey$ = chr$(127) or sh_readkey$ = chr$(8) ) and sh_cpos = 0 then goto 330
  280  if sh_readkey$ = chr$(127) or sh_readkey$ = chr$(8) then sh_readline$ = left$(sh_readline$,sh_cpos-1) + right$(sh_readline$,len(sh_readline$)-sh_cpos) : sh_cpos = sh_cpos - 1 : goto 330
  290  if right$(sh_readline$,1) = chr$(13) or right$(sh_readline$,1) = chr$(10) then sh_readline$ = left$(sh_readline$,len(sh_readline$)-1) : goto 330
  300  if asc(sh_readkey$) < 32 or asc(sh_readkey$) > 127 then goto 330 : rem 7 bit ascii only, and strip unknown ctrl bytes
  310  sh_readline$ = left$(sh_readline$,sh_cpos) + sh_readkey$ + right$(sh_readline$,len(sh_readline$)-sh_cpos)
  320  if sh_readkey$ <> "" then sh_cpos = sh_cpos + 1
  330  goto 130
  340  rem esc seq
  350  sh_esc$ = inkey$
  360  if sh_esc$ = chr$(98) then sh_cpos = 0 : rem lowercase b
  370  if sh_esc$ = chr$(102) then sh_cpos = len(sh_readline$) : rem lowercase f
  380  if sh_esc$ = "[" then sh_escchar$ = inkey$
  390  if sh_escchar$ = "3" then sh_escchar$ = polkey$(0.2) : if sh_escchar$ = "~" and sh_cpos < len(sh_readline$) then sh_readline$ = left$(sh_readline$,sh_cpos) + right$(sh_readline$,len(sh_readline$)-sh_cpos-1) : goto 330
  400  if sh_escchar$ = "A" then gosub 660
  410  if sh_escchar$ = "B" then gosub 720
  420  if sh_escchar$ = "C" then sh_cpos = sh_cpos + 1 : if sh_cpos > len(sh_readline$) then sh_cpos = len(sh_readline$)
  430  if sh_escchar$ = "D" then sh_cpos = sh_cpos - 1 : if sh_cpos < 0 then sh_cpos = 0
  440  goto 130
  450  rem execute
  452  if sh_readline$ = "et" then ?:? "execution time:", sh_ccompleted - sh_cstarted : sh_cstarted = th_time : goto 550
  455  sh_cstarted = th_time
  460  if sh_readline$ = "" then goto 130
  470  gosub 620
  480  gosub 920
  490  gosub 780
  495  if sh_readline$ = "et" then ?:? "execution time:", sh_ccompleted - sh_cstarted : goto 550
  500  if sh_readline$ = "cls" or sh_readline$ = "clear" then cls goto 550
  510  if ups$(left$(sh_readline$,5)) = "RELAY" then ?:? "%access denied" : goto 550
  520  ? : cmd$ = sh_readline$ :stdout$ = "" : if cmd$ <> "" and left$(cmd$,1) <> "!" then if len(cmd$) < 256 then th_exec cmd$, stdout$ : ? fnchomp$(stdout$)
  530  if cmd$ <> "" and left$(cmd$,1) <> "!" then if len(cmd$) > 255 then ? "%cmd error - must be < 256 characters" : goto 550
  540  if left$(cmd$,1) = "!" then cmd$ = mid$(cmd$,2) : th_exec cmd$ : goto 550
  550  sh_readline$ = "" : sh_readkey$ = "" : sh_cpos = 0
  555  sh_ccompleted = th_time
  560  goto 130
  570  rem autocomplete
  580  for c = 0 to ncmds-1
  590  if left$(mycmds$(c),len(sh_readline$)) = sh_readline$ then sh_readline$ = mycmds$(c) : sh_cpos = len(sh_readline$)
  600  next c
  610  goto 130
  620  rem message & command history setter
  630  rhist$(rh) = sh_readline$ : if right$(rhist$(rh),1) = chr$(13) then rhist$(rh) = left$(sh_readline$,len(sh_readline$)-1)
  640  rh = rh + 1 : nh = rh
  650  return
  660  rem message & command history decrement
  670  nh = nh - 1
  680  if nh < 0 then nh = 0
  690  sh_readline$ = rhist$(nh)
  700  sh_cpos = len(sh_readline$)
  710  return
  720  rem message & command history increment
  730  nh = nh + 1
  740  if nh > rh then nh = rh
  750  sh_readline$ = rhist$(nh)
  760  sh_cpos = len(sh_readline$)
  770  return
  780  rem sh_semicolon
  790  for cl = 0 to 1024 : mycmd$(cl) = "" : next cl : rem clear any leftover next commands
  800  nn = 0
  810  sh_delim$ = " ; "
  820  if instr(sh_readline$,sh_delim$) = -1 then return
  830  ?
  840  for ii = 1 to len(sh_readline$)
  850  if mid$(sh_readline$,ii,4) = sh_delim$ then nn = nn + 1 : ii = ii + len(sh_delim$)
  860  mycmd$(nn) = mycmd$(nn) + mid$(sh_readline$,ii,1)
  870  next ii
  880  for k = 0 to nn
  890  th_exec mycmd$(k)
  900  next k
  910  goto 550
  920  rem back ticks
  925  btcmd$ = ""
  930  if instr(sh_readline$,"`") <> -1 then lbtcpos = instr(sh_readline$,"`")
  940  if instr(mid$(sh_readline$,lbtcpos+2),"`") <> -1 then rbtcpos = instr(mid$(sh_readline$,lbtcpos+2),"`")
  950  if mid$(sh_readline$,lbtcpos+2,rbtcpos) <> "" then btcmd$ = mid$(sh_readline$,lbtcpos+2,rbtcpos)
  960  if btcmd$ <> "" then th_exec btcmd$, btcout$ : sh_readline$ = fnreplace$(sh_readline$,"`"+btcmd$+"`",fnchomp$(btcout$))
  965  if instr(sh_readline$,"`") <> -1 then goto 920
  970  return
