PROGRAM StripWhitespaces(INPUT, OUTPUT);
{��������� StripWhitespaces - ������� ������ ������� � ������
 � ����� ������ � ������ ������ ������� ����� �������}
VAR
  Ch: CHAR;
BEGIN
  {������ ������� � ������ ������}
  Ch := ' ';
  WHILE (Ch = ' ') AND (NOT EOLN)
  DO
    READ(Ch);
  WRITE(Ch);
  {������ ���������� �������}
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
