PROGRAM Split(INPUT, OUTPUT);
{�������� INPUT � OUTPUT,������� ��������,� ����� ������
  ��������}
VAR
  Ch, Next: CHAR;
  Odds, Evens: TEXT;

PROCEDURE CopyOut(VAR F1: TEXT; VAR Ch: CHAR);
{�������� F1 � OUTPUT}
BEGIN {CopyOut}
  RESET(F1);
  WHILE NOT EOF(F1)
  DO
    BEGIN
      WHILE NOT EOLN(F1)
      DO
        BEGIN
          READ(F1, Ch);
          WRITE(OUTPUT, Ch)
        END;
      READLN(F1)
    END
END; {CopyOut}

BEGIN {Split}
  {��������� INPUT � Odds � Evens}
  { CopyOut(Odds, Ch); }
  { CopyOut(Evens, Ch); }
  CopyOut(INPUT, Ch);
  WRITELN
END. {Split}
