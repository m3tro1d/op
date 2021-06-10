PROGRAM TestRemove(INPUT, OUTPUT);
{Читает строку из входа, пропускает ее через RemoveExtraBlanks}
USES Queue;
VAR
  Ch: CHAR;

PROCEDURE RemoveExtraBlanks;
{Удаляет лишниe пробелы между словами на одной строке}
VAR
  Ch, Blank, LineEnd: CHAR;
BEGIN {RemoveExtraBlanks}
END; {RemoveExtraBlanks}

BEGIN {TestRemove}
  EmptyQ;
  WRITE('Вход:');
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      WRITE(Ch);
      AddQ(Ch)
    END;
  WRITELN;
  RemoveExtraBlanks;
  WRITE('Выход:');
  HeadQ(Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(Ch);
      DelQ;
      HeadQ(Ch)
    END;
  WRITELN
END. {TestRemove}
