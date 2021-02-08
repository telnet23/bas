   10  in$ = ups$(argv$(1))
   20  if left$(in$,2) = "0X" then in$ = mid$(in$,3)
   30  hn("1") = 1 : hn("2") = 2 : hn("3") = 3 : hn("4") = 4 : hn("5") = 5 : hn("6") = 6 : hn("7") = 7 : hn("8") = 8
   40  hn("9") = 9 : hn("A") = 10 : hn("B") = 11 : hn("C") = 12 : hn("D") = 13 : hn("E") = 14 : hn("F") = 15
   50  for k = 1 to len(in$) : h2b$ = h2b$ + string$(4-len(bin$(hn(mid$(in$,k,1)))),"0") + bin$(hn(mid$(in$,k,1))) : next k
   60  rem ? h2b$
   70  x$ = h2b$
   80  for k = 1 to len(x$)
   90  xk$ = mid$(x$, k, 1)
  100  if xk$ <> "0" and xk$ <> "1" then print "%non-binary" : end
  110  next k
  120  if len(x$) < 32 then print "%too few bits" : end
  130  if len(x$) > 32 then print "%too many bits" : end
  140  e = 0
  150  for k = 2 to 9
  160  if mid$(x$, k, 1) = "1" then e = e + 2^(9-k)
  170  next k
  180  m = 0
  190  for k = 10 to 32
  200  if mid$(x$, k, 1) = "1" then m = m + 2^(9-k)
  210  next k
  220  s = int(mid$(x$, 1, 1))
  230  if e = 255 and m > 0 then print "nan" : end
  240  if e = 255 and s = 0 then print "inf" : end
  250  if e = 255 and s = 1 then print "-inf" : end
  260  if e = 0 then print str$((-1)^s * 2^(-126) * (0+m)) : end
  270  print str$((-1)^s * 2^(e-127) * (1+m)) : end
