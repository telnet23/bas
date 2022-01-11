   10  REM  Wordle
   20  REM  https://github.com/telnet23
   30  REM  08 Jan 2022

   40  CLS
   50  PRINT "WAIT...";
   60  IF N > 0 THEN GOTO 210

   70  OPEN "WORDLE_A.TXT", AS #1
   80  N = 0
   90  INPUT# 1, W$
  100  W$ = UPS$(W$)
  110  N = N + 1
  120  A$(N) = W$
  130  A(W$) = 1
  140  IF EOF(1) > -1 THEN GOTO 90
  150  CLOSE #1

  160  OPEN "WORDLE_L.TXT", AS #1
  170  INPUT# 1, W$
  180  L(UPS$(W$)) = 1
  190  IF EOF(1) > -1 THEN GOTO 170
  200  CLOSE #1

  210  CLS
  220  PRINT SHOW$;
  230  C = 1
  240  W$ = A$(INT(N * RND))

  250  INPUT "GUESS?", G$
  260  G$ = UPS$(G$)
  270  IF LEN(G$) < LEN(W$) THEN PRINT "NOT ENOUGH LETTERS" : GOTO 250
  280  IF LEN(G$) > LEN(W$) THEN PRINT "TOO MANY LETTERS" : GOTO 250
  290  IF NOT A(G$) AND NOT L(G$) THEN PRINT "NOT IN WORD LIST" : GOTO 250

  300  FOR K = 1 TO LEN(W$)
  310    WK$ = MID$(W$, K, 1)
  320    W(WK$) = 0
  330    C$(K) = ""
  340    NEXT K

  350  FOR K = 1 TO LEN(W$)
  360    WK$ = MID$(W$, K, 1)
  370    W(WK$) = W(WK$) + 1
  380    NEXT K

  390  FOR K = 1 TO LEN(W$)
  400    GK$ = MID$(G$, K, 1)
  410    WK$ = MID$(W$, K, 1)
  420    IF C$(K) = "" AND GK$ = WK$ THEN C$(K) = "[42m" : W(GK$) = W(GK$) - 1
  430    NEXT K

  440  FOR K = 1 TO LEN(W$)
  450    GK$ = MID$(G$, K, 1)
  460    IF C$(K) = "" AND W(GK$) > 0 THEN C$(K) = "[43m" : W(GK$) = W(GK$) - 1
  470    NEXT K

  480  FOR L = 0 TO 2
  490    FOR K = 1 TO LEN(W$)
  500      IF C$(K) THEN PRINT CHR$(27) C$(K);
  510      GK$ = " "
  520      IF L = 1 THEN GK$ = MID$(G$, K, 1)
  530      PRINT " " GK$ " ";
  540      IF C$(K) THEN PRINT CHR$(27) "[49m";
  550      PRINT " ";
  560      NEXT K
  570    PRINT
  580    NEXT L

  590  C = C + 1
  600  IF W$ <> G$ AND C < 7 THEN GOTO 250
  610  PRINT "THE WORD WAS " W$
