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
PROCEDURE Sort(VAR F1, F2: TEXT);
  { Меняет местами соседние символы из F1 в F2
    по возрастанию }
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
          {Выводим min(Ch1,Ch2) в F2, записывая
          отсортированные символы}
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
  { Копируем INPUT в F1 }
  REWRITE(F1);
  Copy(INPUT, F1);
  Sorted := 'N';
  WHILE Sorted = 'N'
  DO
    BEGIN
      Sorted := 'Y';
      { Копируем F1 в F2,проверяя отсортированность
       и переставляя первые соседние символы по порядку}
      RESET(F1);
      REWRITE(F2);
      Sort(F1, F2);
      { Копируем F2 в F1 }
      RESET(F2);
      REWRITE(F1);
      Copy(F2, F1)
    END;
  { Копируем F1 в OUTPUT }
  RESET(F1);
  Copy(F1, OUTPUT)
END. { BubbleSort }
