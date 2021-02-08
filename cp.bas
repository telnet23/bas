   10  if len(argv$(1)) < 2 then gosub 160 : end
   20  if argv$(2) = "" then gosub 160 end
   30  if instr(dir$, argv$(1)) < 0 then print "%file not found" : end
   40  myf$ = mid$(mid$(dir$, instr(dir$, argv$(1))),2)
   50  myf$ = left$(myf$, instr(myf$, " "))
   60  print " copy " + myf$ + " to " + argv$(2) "? y/N" ; : cont1$ = inkey$
   70  print
   80  if cont1$ <> "y" then end
   90  gosub 180
  100  gosub 210
  110  gosub 320
  120  if fsize = 0 then print "%file invalid, cannot copy 0 bytes" : end
  130  gosub 370
  140  print " done (" + str$(nint(fsize/1000)) + " KB copied)"
  150  end
  160  rem usage
  170  print "%usage: " + argv$(0) + " <sourcefile> <targetfile>" : return
  180  rem check if arg2 exists!
  190  if instr(dir$, " " + argv$(2) + " ") > -1 then print "%already exists, cannot overwrite" : end
  200  return
  210  rem open file
  220  lnm = 1
  230  open myf$, as #1
  240  if EOF(1) = -1 then goto 290
  250  input# 1, A$
  260  file$(lnm) = A$
  270  lnm = lnm + 1
  280  goto 240
  290  close #1
  300  flines = lnm
  310  return
  320  rem get file size
  330  for o = 1 to flines
  340  fsize = fsize + len(file$(o))
  350  next o
  360  return
  370  rem create new file
  380  open argv$(2), as #1
  390  for r = 1 to flines : print# 1, file$(r) : gosub 9000 : next r
  400  close #1
  410  return
 9000  if file$(r) = "" then print# 1, "",
 9010  return
