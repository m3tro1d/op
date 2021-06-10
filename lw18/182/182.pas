PROGRAM TestReadNumber(INPUT, OUTPUT);
VAR
  Number: INTEGER;
  
PROCEDURE ReadDigit(VAR F: TEXT; VAR D: INTEGER);
{Считывает текущий символ из файл. Если он - цифра, возвращает его 
 преобразуя в значение типа INTEGER. Если считанный символ не цифра
 возвращает -1}
VAR
  Ch: CHAR;
BEGIN {ReadDigit}
  D := -1;
  IF NOT EOLN(F)
  THEN
    BEGIN
      READ(F, Ch);
      IF Ch = '0' THEN D := 0 ELSE
      IF Ch = '1' THEN D := 1 ELSE
      IF Ch = '2' THEN D := 2 ELSE
      IF Ch = '3' THEN D := 3 ELSE
      IF Ch = '4' THEN D := 4 ELSE
      IF Ch = '5' THEN D := 5 ELSE
      IF Ch = '6' THEN D := 6 ELSE
      IF Ch = '7' THEN D := 7 ELSE
      IF Ch = '8' THEN D := 8 ELSE
      IF Ch = '9' THEN D := 9
    END
END; {ReadDigit}

PROCEDURE CheckSafeToExpand(VAR N, D: INTEGER; VAR Flag: BOOLEAN);
{Проверяет, безопасно ли добавить к числу N разряд D}
BEGIN {CheckSafeToExpand}
  Flag := (N < MAXINT DIV 10) OR ((N = MAXINT DIV 10) AND (D <= MAXINT MOD 10))
END; {CheckSafeToExpand}

PROCEDURE ReadNumber(VAR F: TEXT; VAR N: INTEGER);
{Преобразует строку цифр из файла до первого нецифрового символа,  в соответствующее целое число N}
VAR
  D: INTEGER;
  IsSafeToExpand: BOOLEAN;
BEGIN {ReadNumber}
  N := 0;
  D := 0;
  WHILE (D <> -1) AND (N <> -1)
  DO
    BEGIN
      CheckSafeToExpand(N, D, IsSafeToExpand);
      IF IsSafeToExpand
      THEN
        N := N * 10 + D
      ELSE
        N := -1;
      ReadDigit(F, D)
    END
END; {ReadNumber}

BEGIN {TestReadNumber}
  WRITELN(MAXINT);
  ReadNumber(INPUT, Number);
  WRITELN(OUTPUT, Number)
END. {TestReadNumber}
