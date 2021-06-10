PROGRAM RecursiveSortTest(INPUT, OUTPUT);
VAR
  F: TEXT;
  Ch: CHAR;

PROCEDURE CopyLine(VAR Source, Destination: TEXT);
{Копирует строку из Source в Destination}
BEGIN
  WHILE NOT EOLN(Source)
  DO
    BEGIN
      READ(Source, Ch);
      WRITE(Destination, Ch)
    END;
  READLN(Source);
  WRITELN(Destination)
END;

PROCEDURE RecursiveSort(VAR F1: TEXT);
VAR 
  F2, F3: TEXT;
  Ch: CHAR;

PROCEDURE Split(VAR F1, F2, F3: TEXT);
{Разбивает F1 на F2, F3}
VAR 
  Ch, Switch: CHAR;
BEGIN {Split}
  RESET(F1);
  REWRITE(F2);
  REWRITE(F3);
  {Копировать F1 попеременно в F2 и F3}
  Switch := '2';
  WHILE NOT EOLN(F1)
  DO
    BEGIN
      READ(F1, Ch);
      IF Switch = '2'
      THEN
        BEGIN
          WRITE(F2, Ch);
          Switch := '3'
        END
      ELSE
        BEGIN
          WRITE(F3, Ch);
          Switch := '2'
        END
    END;
  WRITELN(F2);
  WRITELN(F3)
END; {Split}

PROCEDURE Merge(VAR F1, F2, F3: TEXT);
{Сливает F2, F3 в F1  в сортированном порядке}
VAR 
  Ch2, Ch3: CHAR;
BEGIN {Merge}
  RESET(F2);
  RESET(F3);
  REWRITE(F1);
  IF NOT EOLN(F2)
  THEN
    READ(F2, Ch2);
  IF NOT EOLN(F3)
  THEN
    READ(F3, Ch3);
  WHILE (NOT EOF(F2)) AND (NOT EOF(F3))
  DO
    BEGIN
      IF Ch2 < CH3
      THEN 
        BEGIN
          WRITE(F1, Ch2);
          READ(F2, Ch2)
        END
      ELSE
        BEGIN
          WRITE(F1, Ch3);
          READ(F3, Ch3)
        END
    END;
  {Копировать остаток F2 в F1}
  WHILE NOT EOF(F2)
  DO
    BEGIN
      WRITE(F1, Ch2);
      READ(F2, Ch2)
    END;
  {Копировать остаток F3 в F1}
  WHILE NOT EOF(F3)
  DO
    BEGIN
      WRITE(F1, Ch3);
      READ(F3, Ch3)
    END;
  WRITELN(F1)
END; {Merge}

BEGIN {RecursiveSort}
  RESET(F1);
  IF NOT EOLN(F1)
  THEN
    READ(F1, Ch);
    BEGIN
      IF NOT EOLN(F1)
      THEN {Файл имеет как минимум 2 символа}
        BEGIN
          Split(F1, F2, F3);
          RecursiveSort(F2);
          RecursiveSort(F3);
          Merge(F1, F2, F3)
        END
    END
END; {RecursiveSort}

BEGIN {RecursiveSortTest}
  REWRITE(F);
  CopyLine(INPUT, F);
  RecursiveSort(F);
  RESET(F);
  CopyLine(F, OUTPUT)
END. {RecursiveSortTest}
