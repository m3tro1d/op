PROGRAM BubbleSort(INPUT, OUTPUT);
  { ��������� ������ ������ INPUT � OUTPUT }
VAR
  Sorted: CHAR;
  F1, F2: TEXT;
PROCEDURE Copy(VAR F1, F2: TEXT);
  { �������� ������ �� F1 � F2 }
VAR
  Ch: CHAR;
BEGIN { Copy } 
  WHILE NOT EOLN(F1)
  DO
    BEGIN
      READ(F1, Ch);
      WRITE(F2, Ch)
    END;
  WRITELN(F2)
END; { Copy }
PROCEDURE Sort(VAR F1, F2: TEXT);
  { ������ ������� �������� ������� �� F1 � F2
    �� ����������� }
VAR
  Ch1, Ch2: CHAR;
BEGIN { Sort }
  IF NOT EOLN(F1)
  THEN
    BEGIN
      READ(F1, Ch1);
      WHILE NOT EOLN(F1)
      DO
        BEGIN
          READ(F1, Ch2);
          {������� min(Ch1,Ch2) � F2, ���������
          ��������������� �������}
          IF Ch1 <= Ch2
          THEN
            BEGIN
              WRITE(F2, Ch1);
              Ch1 := Ch2
            END
          ELSE
            BEGIN
              WRITE(F2, Ch2);
              Sorted := 'N'
            END          
        END;
      WRITE(F2, Ch1);
      WRITELN(F2)
    END
END; { Sort }
BEGIN { BubbleSort }
  { �������� INPUT � F1 }
  REWRITE(F1);
  Copy(INPUT, F1);
  Sorted := 'N';
  WHILE Sorted = 'N'
  DO
    BEGIN
      { �������� F1 � F2,�������� �����������������
       � ����������� ������ �������� ������� �� �������}
      RESET(F1);
      REWRITE(F2);
      Sort(F1, F2);
      { �������� F2 � F1 }
      RESET(F2);
      REWRITE(F1);
      Copy(F2, F1);
      Sorted := 'Y'
    END;
  { �������� F1 � OUTPUT }
  RESET(F1);
  Copy(F1, OUTPUT)
END. { BubbleSort }
