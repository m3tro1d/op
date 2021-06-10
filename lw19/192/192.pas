PROGRAM AverageScore(INPUT, OUTPUT);
CONST
  NumberOfScores = 4;
  ClassSize = 4;
  DivisionAccuracy = 10;
TYPE
  Score = 0 .. 100;
VAR
  WhichScore: 1 .. NumberOfScores;
  Student: 1 .. ClassSize;
  NextScore: Score;
  Ave, TotalScore, ClassTotal: INTEGER;
  NotEnoughScores: BOOLEAN;
  Surname: TEXT;
  
PROCEDURE ReadSurname(VAR FIn, Surname: TEXT);
{Скопировать фамилию из FIn в FOut}
VAR
  Ch: CHAR;
BEGIN {ReadSurname}
  IF NOT EOLN(FIn)
  THEN
    READ(FIn, Ch);
  WHILE (NOT EOLN(FIn)) AND (Ch <> ' ')
  DO
    BEGIN           
      WRITE(Surname, Ch);
      READ(FIn, Ch)
    END;
  WRITELN(Surname)
END; {ReadSurname}

PROCEDURE WriteSurname(VAR FOut, Surname: TEXT);
{Скопировать фамилию из Surname в FOut}
VAR
  Ch: CHAR;
BEGIN {WriteSurname}
  WHILE NOT EOLN(Surname)
  DO
    BEGIN
      READ(Surname, Ch);
      WRITE(FOut, Ch)
    END;
  READLN(Surname)
END; {WriteSurname}
  
BEGIN {AverageScore}
  ClassTotal := 0;
  WRITELN('Student averages:');
  Student := 1;    
  NotEnoughScores := FALSE;
  WHILE (Student <= ClassSize) AND (NOT NotEnoughScores)
  DO 
    BEGIN
      TotalScore := 0;
      WhichScore := 1;
      REWRITE(Surname);
      ReadSurname(INPUT, Surname);  
      WHILE (WhichScore <= NumberOfScores) AND (NOT NotEnoughScores)
      DO
        BEGIN
          IF NOT EOLN
          THEN
            READ(NextScore)
          ELSE
            NotEnoughScores := TRUE;
          TotalScore := TotalScore + NextScore;
          WhichScore := WhichScore + 1
        END;
      IF NOT NotEnoughScores
      THEN
        BEGIN
          READLN;
          RESET(Surname);
          WriteSurname(OUTPUT, Surname);
          WRITE(' ');
          TotalScore := TotalScore * DivisionAccuracy;
          Ave := TotalScore DIV NumberOfScores;
          IF Ave MOD DivisionAccuracy >= DivisionAccuracy DIV 2
          THEN
            WRITELN(Ave DIV DivisionAccuracy + 1)
          ELSE
            WRITELN(Ave DIV DivisionAccuracy);
          ClassTotal := ClassTotal + TotalScore;
          Student := Student + 1
        END
    END;
  WRITELN;
  IF NOT NotEnoughScores
  THEN
    BEGIN
      WRITELN('Class average:');
      ClassTotal := ClassTotal DIV (ClassSize * NumberOfScores);
      WRITELN(ClassTotal DIV DivisionAccuracy, '.', ClassTotal MOD DivisionAccuracy:1)
    END
  ELSE
    WRITELN('Error: not enough scores')
END. {AverageScore}
