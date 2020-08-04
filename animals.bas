8000  REM  Animals
8010  REM  https://github.com/telnet23
8020  REM  15 June 2020

8025  CLS
8030  DEF FNY(P) = 2 * P + 1
8040  DEF FNN(P) = 2 * P + 2
8050  T$(0) = "Is it a water animal?"
8060  T$(1) = "an octopus"
8070  T$(2) = "a snake"

8080  P = 0
8090  IF P = 0 OR LF THEN LF = 0 : PRINT
8100  IF P = 0 THEN PRINT "Think of an animal."

8120  S$ = T$(P)
8130  L = T$(FNY(P)) = "" OR T$(FNN(P)) = ""
8140  IF L THEN S$ = "Are you thinking of " + S$ + "?"
8150  PRINT S$ + " (yes/no/reset/dump) ";
8160  INPUT "", A$
8170  A$ = LEFT$(A$, 1)
8180  IF A$ = "y" AND L THEN GOTO 8250
8190  IF A$ = "y" THEN P = FNY(P)
8200  IF A$ = "n" AND L THEN GOTO 8310
8210  IF A$ = "n" THEN P = FNN(P)
8220  IF A$ = "r" THEN GOTO 8030
8230  IF A$ = "d" THEN GOTO 8450
8240  GOTO 8090

8250  PRINT "I knew it! Play again? (yes/no) ";
8260  INPUT "", A$
8270  A$ = LEFT$(A$, 1)
8280  IF A$ = "y" THEN GOTO 8080
8290  IF A$ = "n" THEN GOTO 500
8300  GOTO 8250

8310  PRINT "What are you thinking of, then? ";
8320  INPUT "", W$
8330  IF W$ = "" THEN GOTO 8310
8340  PRINT "What is a yes-no question that differentiates " + T$(P) + " and " + W$ + "? ";
8350  INPUT "", Q$
8360  IF Q$ = "" THEN GOTO 8340
8370  PRINT "For " + W$ + ", what is the answer to the question? (yes/no) ";
8380  INPUT "", A$
8390  A$ = LEFT$(A$, 1)
8400  IF A$ = "y" THEN T$(FNY(P)) = W$ : T$(FNN(P)) = T$(P) : GOTO 8430
8410  IF A$ = "n" THEN T$(FNN(P)) = W$ : T$(FNY(P)) = T$(P) : GOTO 8430
8420  GOTO 8370
8430  T$(P) = Q$
8440  GOTO 8080

8450  PRINT
8460  SP = 1 : S(SP) = 0
8470  IF SP < 1 THEN LF = 1 : GOTO 8090
8480  Q = S(SP) : SP = SP - 1
8490  V$ = T$(Q)
8500  IF P = Q THEN V$ = CHR$(27) + "[1m" + V$ + CHR$(27) + "[22m"
8510  U$ = "   "
8520  L = INT(LOG(Q + 1) / LOG(2))
8530  IF L = 0 THEN V$ = CHR$(27) + "[33m" + V$ + CHR$(27) + "[39m" : GOTO 8670
8540  IF L = 1 THEN GOTO 8590
8550  FOR K = 1 TO L - 1
8560  IF X(K) THEN U$ = U$ + "   " : GOTO 8580
8570  U$ = U$ + CHR$(27) + "(0" + "x  " + CHR$(27) + "(B"
8580  NEXT K
8590  IF Q MOD 2 THEN GOTO 8650
8600  X(L) = 1
8610  X(L + 1) = 0
8620  U$ = U$ + CHR$(27) + "(0" + "mq " + CHR$(27) + "(B"
8630  V$ = CHR$(27) + "[31m" + V$ + CHR$(27) + "[39m"
8640  GOTO 8670
8650  U$ = U$ + CHR$(27) + "(0" + "tq " + CHR$(27) + "(B"
8660  V$ = CHR$(27) + "[32m" + V$ + CHR$(27) + "[39m"
8670  PRINT U$ + V$
8680  IF T$(FNN(Q)) THEN SP = SP + 1 : S(SP) = FNN(Q)
8690  IF T$(FNY(Q)) THEN SP = SP + 1 : S(SP) = FNY(Q)
8700  GOTO 8470
