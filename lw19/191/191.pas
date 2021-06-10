PROGRAM AverageScore(INPUT, OUTPUT);
CONST
  NumberOfScores = 4;
  ClassSize = 4;
TYPE
  Score = 0 .. 100;
VAR
  WhichScore: 1 .. NumberOfScores;
  Student: 1 .. ClassSize;
  NextScore: Score;
  Ave, TotalScore, ClassTotal: INTEGER;
  NotEnoughScores: BOOLEAN;
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
          WRITE(Student, ': ');
          TotalScore := TotalScore * 10;
          Ave := TotalScore DIV NumberOfScores;
          IF Ave MOD 10 >= 5
          THEN
            WRITELN(Ave DIV 10 + 1)
          ELSE
            WRITELN(Ave DIV 10);
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
      WRITELN(ClassTotal DIV 10, '.', ClassTotal MOD 10:1)
    END
  ELSE
    WRITELN('Error: not enough scores')
END. {AverageScore}
