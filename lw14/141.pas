PROGRAM ReverseTest(INPUT, OUTPUT);
PROCEDURE Reverse(VAR F1, F2: TEXT);
{Реверсирует строку из F1 в F2}
VAR
  Ch: CHAR;
BEGIN {Reverse}
  IF NOT EOLN(F1)
  THEN
    BEGIN
      READ(F1, Ch);
      Reverse(F1, F2);
      WRITE(F2, Ch)
    END
END; {Reverse}
BEGIN {ReverseTest} 
  Reverse(INPUT, OUTPUT);
  WRITELN(OUTPUT)
END. {ReverseTest}

