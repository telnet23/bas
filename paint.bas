10  REM  Paint with Cursor in BASIC
20  REM  https://github.com/telnet23
30  REM  10 September 2020
40  CLS
50  PRINT CHR$(27) + "[?1000h";
60  PRINT CHR$(27) + "[?25l";
70  PRINT "Type QQQ to return."
80  A$ = ""
90  X$ = INKEY$
100  A$ = A$ + X$
110  IF LEN(A$) < 3 THEN GOTO 90
120  IF UPS$(MID$(A$, LEN(A$) - 2, 3)) = "QQQ" THEN GOTO 220
130  IF LEN(A$) < 6 THEN GOTO 90
140  IF MID$(A$, LEN(A$) - 5, 4) <> CHR$(27) + "[M " THEN GOTO 90
150  X = ASC(MID$(A$, LEN(A$) - 1, 1)) - 32
160  Y = ASC(MID$(A$, LEN(A$) - 0, 1)) - 32
170  PRINT CHR$(27) + "[" + STR$(Y) + ";" + STR$(X) + "H";
180  IF SCR(X,Y) THEN PRINT " ";
190  IF NOT SCR(X,Y) THEN PRINT CHR$(27) + "[7m" + " " + CHR$(27) + "[27m";
200  SCR(X,Y) = NOT SCR(X,Y)
210  GOTO 80
220  PRINT CHR$(27) + "[?25h";
230  PRINT CHR$(27) + "[?1000l";
