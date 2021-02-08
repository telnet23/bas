   10  def fnreplace$(s$,f$,r$) = left$(s$,instr(s$,f$)) + r$ + mid$(s$,instr(s$,f$)+len(f$)+1)
   20  print fnreplace$("Hello there everyone","there","and goodbye")
