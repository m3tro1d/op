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
BEGIN { BubbleSort }
  { �������� INPUT � F1 }
  REWRITE(F1);
  Copy(INPUT, F1);
  Sorted := 'Y';
  WHILE Sorted = 'N'
  DO
    BEGIN
      { �������� F1 � F2,�������� �����������������
       � ����������� ������ �������� ������� �� �������}
      { �������� F2 � F1 }
    END;
  { �������� F1 � OUTPUT }
  RESET(F1);
  Copy(F1, OUTPUT)
END. { BubbleSort }
