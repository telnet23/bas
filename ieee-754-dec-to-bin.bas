6000  REM  IEEE 754 - Decimal to Binary
6010  CLS
6020  PRINT SHOW$;
6030  PRINT "Enter a blank line to return."
6040  PRINT "Note: Only normal numbers are supported."
6140  PRINT
6150  PRINT "Decimal number";
6160  INPUT IN$
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
6470  PRINT
6480  PRINT STR$(S) + E$              + M$
6490  PRINT "S"     + STRING$(8, "E") + STRING$(23, "M")
6500  GOTO 6140
