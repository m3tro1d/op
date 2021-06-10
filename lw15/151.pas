PROGRAM BubbleSort(INPUT, OUTPUT);
{��������� ������ ������ INPUT � OUTPUT}
VAR
  F: TEXT;

PROCEDURE CopyLine(VAR Source, Destination: TEXT);
{CopyLine: �������� ������ ������ �� Source � Destination}
VAR
  Ch: CHAR;
BEGIN {CopyLine}
  WHILE NOT EOLN(Source)
  DO
    BEGIN
      READ(Source, Ch);
      WRITE(Destination, Ch)
    END;
  READLN(Source);
  WRITELN(Destination)
END; {CopyLine}

PROCEDURE SortIteration(VAR F1, F2: TEXT; VAR Sorted: CHAR);
{SortIteration: ��������� 1 ������ ���������� �� F1 � F2}
VAR
  Ch1, Ch2: CHAR;
BEGIN {SortIteration}
  IF NOT EOLN(F1)
  THEN
    BEGIN
      READ(F1, Ch1);
      WHILE NOT EOLN(F1)
      DO { �� ������� ���� ��� ������� �������� ��� Ch1,Ch2 }
        BEGIN
          READ(F1, Ch2);
          { �������   min(Ch1,Ch2) �  F2, ���������
            ��������������� ������� }
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
      WRITELN(F2, Ch1) { ������� ��������� ������ � F2 }
    END
END; {SortIteration}

PROCEDURE Sort(VAR F1: TEXT);
{Sort: ��������� ���� F1}
VAR
  F2: TEXT;
  Sorted: CHAR;
BEGIN {Sort}
  Sorted := 'N';
  WHILE Sorted = 'N'
  DO
    BEGIN
      {�������� F1 � F2, �������� ����������}
      Sorted := 'Y';
      RESET(F1);
      REWRITE(F2);
      SortIteration(F1, F2, Sorted);
      { �������� F2 � F1 }
      RESET(F2);
      REWRITE(F1);
      CopyLine(F2, F1)
    END
END; {Sort}

BEGIN {BubbleSort}
  REWRITE(F);
  CopyLine(INPUT, F);
  Sort(F);
  RESET(F);
  CopyLine(F, OUTPUT)
END. {BubbleSort}
