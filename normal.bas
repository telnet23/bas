1000  REM  Normal
1010  CLS

1030  PI = 3.14159265358979
1040  ROWS = 24
1050  COLS = 80
1060  SIGMA = COLS / 6
1070  MU = COLS / 2
1080  DOT = 50

1100  SLEEP 0  REM  Fool the stupid TRY ADDING SLEEP TO YOUR LOOPS check
1110  LOCATE 1, 1
1120  I = I + 1
1130  PRINT STR$(I);

1140  U1 = RND(1)
1150  U2 = RND(1)
1160  Z = SQRT(-2 * LOG(U1)) * COS(2 * PI * U2)
1170  X = INT(MU + SIGMA * Z)
1180  IF X < 1 OR X > COLS THEN GOTO 1100
1190  COUNT(X) = COUNT(X) + 1

1200  IF COUNT(X) MOD DOT > 0 THEN GOTO 1100
1210  Y = ROWS + 1 - COUNT(X) / DOT
1220  IF Y < 1 THEN GOTO 1260
1230  LOCATE Y, X
1240  PRINT CHR$(27) + "[7m" + " " + CHR$(27) + "[27m";
1250  GOTO 1100

1260  LOCATE ROWS, 1
1270  GOTO 90000
