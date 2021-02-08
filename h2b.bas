   10  in$ = argv$(1)
   20  if left$(in$,2) = "0x" then in$ = mid$(in$,3)
   30  if len(in$) <> 8 then ? "%usage: " argv$(0) " <hex>" : end
   40  hn("1") = 1 : hn("2") = 2 : hn("3") = 3 : hn("4") = 4 : hn("5") = 5 : hn("6") = 6 : hn("7") = 7 : hn("8") = 8
   50  hn("9") = 9 : hn("a") = 10 : hn("b") = 11 : hn("c") = 12 : hn("d") = 13 : hn("e") = 14 : hn("f") = 15
   60  for k = 1 to len(in$) : h2b$ = h2b$ + string$(4-len(bin$(hn(mid$(in$,k,1)))),"0") + bin$(hn(mid$(in$,k,1))) : next k
   70  ? h2b$
