PROGRAM Split(INPUT, OUTPUT);
{Копирует INPUT в OUTPUT,сначала нечетные,а затем четные
  элементы}
VAR
  Ch, Next: CHAR;
  Odds, Evens: TEXT;

PROCEDURE CopyOut(VAR F1: TEXT; VAR Ch: CHAR);
{Копируем F1 в OUTPUT}
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
  {Разделяет INPUT в Odds и Evens}
  { CopyOut(Odds, Ch); }
  { CopyOut(Evens, Ch); }
  CopyOut(INPUT, Ch);
  WRITELN
END. {Split}
