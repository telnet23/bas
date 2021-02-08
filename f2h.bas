    0  IN$ = ARGV$(1)
   10  def fnb2d(s$) = abs(mid$(s$,1,1))*2^3 + abs(mid$(s$,2,1))*2^2 + abs(mid$(s$,3,1))*2^1 + abs(mid$(s$,4,1))*2^0
 6170  IF LEN(IN$) = 0 THEN GOTO 500
 6180  IN = VAL(IN$)
 6190  S = (IN < 0)
 6200  E = 0
 6210  M$ = ""    REM  Easier to use string since BASIC doesn't have native bitwise operators
 6220  IN = ABS(IN)
 6230  IF IN = 0 THEN GOTO 6440
 6240  E = 126
 6250  IPART = INT(IN)
 6260  FPART = IN - IPART
 6270  IF IPART = 0 THEN GOTO 6330
 6280  E = E + 1
 6290  QUOT = INT(IPART / 2)
 6300  M$ = STR$(IPART - QUOT * 2) + M$
 6310  IPART = QUOT
 6320  GOTO 6270
 6330  M$ = LEFT$(M$, 24)    REM  For now, MSB is 1
 6340  IF FPART = 0 THEN GOTO 6430
 6350  IF LEN(M$) > 23 THEN GOTO 6430    REM  We stop at 23, so LSB will be rounded down always
 6360  PROD = INT(FPART * 2)
 6370  IF PROD > 0 OR LEN(M$) > 0 THEN GOTO 6400
 6380  E = E - 1
 6390  GOTO 6410
 6400  M$ = M$ + STR$(PROD)
 6410  FPART = FPART * 2 - PROD
 6420  GOTO 6340
 6430  M$ = MID$(M$, 2)    REM  Truncate the MSB
 6440  M$ = M$ + STRING$(23 - LEN(M$), "0")
 6450  E$ = BIN$(E)
 6460  E$ = STRING$(8 - LEN(E$), "0") + E$
 6480  o$ = STR$(S) + E$              + M$
 6490  rem ? o$
 6495  ? "0x" ;
 6500  for i = 1 to len(o$) step 4
 6510  print hex$( fnb2d( mid$(o$,i,4) ) ) ;
 6520  next i
 6550  ?
