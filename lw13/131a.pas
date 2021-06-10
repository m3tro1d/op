PROGRAM BubbleSort(INPUT, OUTPUT);
  { Сортируем первую строку INPUT в OUTPUT }
VAR
  Sorted: CHAR;
  F1, F2: TEXT;
PROCEDURE Copy(VAR F1, F2: TEXT);
  { Копирует строку из F1 в F2 }
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
  { Копируем INPUT в F1 }
  REWRITE(F1);
  Copy(INPUT, F1);
  Sorted := 'Y';
  WHILE Sorted = 'N'
  DO
    BEGIN
      { Копируем F1 в F2,проверяя отсортированность
       и переставляя первые соседние символы по порядку}
      { Копируем F2 в F1 }
    END;
  { Копируем F1 в OUTPUT }
  RESET(F1);
  Copy(F1, OUTPUT)
END. { BubbleSort }
