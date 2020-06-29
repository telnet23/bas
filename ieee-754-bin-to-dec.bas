7000  REM  IEEE 754 - Binary to Decimal
7010  CLS
7030  PRINT "Enter a blank line to return."

7040  PRINT
7050  PRINT "Binary number";
7060  INPUT X$
7070  IF X$ = "" THEN GOTO 500

7080  FOR K = 1 TO LEN(X$)
7090  XK$ = MID$(X$, K, 1)
7100  IF XK$ <> "0" AND XK$ <> "1" THEN PRINT "Error: Non-binary" : GOTO 7040
7110  NEXT K

7120  IF LEN(X$) < 32 THEN PRINT "Error: Too few bits" : GOTO 7040
7130  IF LEN(X$) > 32 THEN PRINT "Error: Too many bits" : GOTO 7040

7140  E = 0
7150  FOR K = 2 TO 9
7160  IF MID$(X$, K, 1) = "1" THEN E = E + 2^(9-K)
7170  NEXT K

7180  M = 0
7190  FOR K = 10 TO 32
7200  IF MID$(X$, K, 1) = "1" THEN M = M + 2^(9-K)
7210  NEXT K

7220  S = INT(MID$(X$, 1, 1))
7230  IF E = 255 AND M > 0 THEN PRINT "NaN" : GOTO 7040
7240  IF E = 255 AND S = 0 THEN PRINT "Inf" : GOTO 7040
7250  IF E = 255 AND S = 1 THEN PRINT "-Inf" : GOTO 7040
7260  IF E = 0 THEN PRINT STR$((-1)^S * 2^(-126) * (0+M)) : GOTO 7040
7270  PRINT STR$((-1)^S * 2^(E-127) * (1+M)) : GOTO 7040
