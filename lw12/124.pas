PROGRAM StripWhitespaces(INPUT, OUTPUT);
{ѕрограмма StripWhitespaces - удал€ет лишние пробелы в начале
 и конце строки и больше одного пробела между словами}
VAR
  Ch: CHAR;
BEGIN
  {”брать пробелы в начале строки}
  Ch := ' ';
  WHILE (Ch = ' ') AND (NOT EOLN)
  DO
    READ(Ch);
  WRITE(Ch);
  {”брать оставшиес€ пробелы}
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      IF Ch <> ' '
      THEN
        WRITE(Ch)
      ELSE
        BEGIN
          WHILE (Ch = ' ') AND (NOT EOLN)
          DO
            READ(Ch);
          WRITE(' ', Ch)
        END
    END;
  WRITELN
END.
