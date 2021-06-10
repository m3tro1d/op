PROGRAM PascalFormatter(INPUT, OUTPUT);
{��������� PascalFormatter: ����������� pascal-���������
 � ������� ������ BEGIN...END �� �������� Coding Conventions
 ������� �����, ��-13}
VAR
  {���������� ����}
  W1, W2, W3, W4, W5, W6, W7: CHAR; 
  {EndOccured ���������� ��������� END. � ������� ������:
   0 - END. ��� �� ����������;
   1 - END. ����������.}
  EndOccured: CHAR;  
PROCEDURE ProcessSemicolons;
{��������� ProcessSemicolons: ������������ ����� � �������}
BEGIN   
  {��������� �����������: ������ �� ��� ���, ���� ��
   �������� ';' ��� 'E', �.�. ��������� END.}
  WHILE (NOT EOLN) AND (W7 <> ';') AND (W7 <> 'E')
  DO
    READ(W7);
  IF W7 = ';'
  THEN
    BEGIN
      WHILE (NOT EOLN) AND (W7 = ';')
      DO
        BEGIN
          WRITE(W7);
          READ(W7)
        END
    END;
  WRITELN;  
  IF (W7 <> 'E')
  THEN
    WRITE('  ');
  IF W7 <> ' '
  THEN
    WRITE(W7)
END;
PROCEDURE ProcessString; 
{��������� ProcessString: ������������ ��������� ��������}
BEGIN
  IF NOT EOLN
  THEN
    READ(W7);
  WRITE('''');
  WHILE (NOT EOLN) AND (W7 <> '''')
  DO
    BEGIN
      WRITE(W7);
      READ(W7)
    END
END;
PROCEDURE ProcessFunctionCall;
{��������� ProcessFunctionCall: ������������ ����������� ������
 (��� �� ����������)}
BEGIN
  {���������� ������� ����� ����������� �������}
  WHILE (NOT EOLN) AND (W7 = ' ')
  DO
    READ(W7); 
  {���� ��������� ������, �������, ��������� ������� � ��������
   �� ���, ��� ���� - ����� �������}
  IF W7 = '('
  THEN
    BEGIN
      WRITE('(');
      WHILE (NOT EOLN) AND (W7 <> ')')
      DO
        BEGIN
          READ(W7);
          {��������� �����}
          IF W7= ''''
          THEN
            ProcessString;
          IF W7 <> ' '
          THEN
            WRITE(W7);
          IF W7 = ','
          THEN
            WRITE(' ')
        END
    END;
  IF NOT EOLN
  THEN
    ProcessSemicolons
END;
BEGIN
  {�������������}
  W1 := ' ';  
  W2 := ' ';
  W3 := ' ';
  W4 := ' ';
  W5 := ' ';
  W6 := ' ';
  W7 := ' ';
  EndOccured := '0';
  
  {��������� INPUT:
   W7 ��� ���� ������ ��������� � ���������� 'detached head'
   (��������, � ������� ProcessParentheses), �� ���� ���������� "��������"
   W7, ������� ������ ��� �� ���������.}
  WHILE (NOT EOLN) AND (EndOccured = '0')
  DO
    BEGIN
      {�������� ����}
      W1 := W2; 
      W2 := W3;
      W3 := W4;
      W4 := W5;
      W5 := W6;
      W6 := W7;
      READ(W7);
      {���������� ��� �������}
      WHILE (NOT EOLN) AND (W7 = ' ')
      DO
        READ(W7);

      {������� ���, �� ����������� ������ ��������� ������������}
      IF W7 <> ':'
      THEN
        WRITE(W7);
      
      {�������� �� BEGIN}
      IF (W3 = 'B') AND (W4 = 'E') AND (W5 = 'G') AND (W6 = 'I') AND (W7 = 'N')
      THEN
        BEGIN
          WRITELN;
        END;
      
      {�������� �� END.}
      IF (W4 = 'E') AND (W5 = 'N') AND (W6 = 'D') AND (W7 = '.')
      THEN
        EndOccured := '1';
           
      {�������� �� RESET}  
      IF (W3 = 'R') AND (W4 = 'E') AND (W5 = 'S') AND (W6 = 'E') AND (W7 = 'T')
      THEN
        BEGIN
          IF NOT EOLN
          THEN 
            READ(W7);
          ProcessFunctionCall 
        END;
           
      {�������� �� REWRITE}  
      IF (W1 = 'R') AND (W2 = 'E') AND (W3 = 'W') AND (W4 = 'R') AND (W5 = 'I') AND (W6 = 'T') AND (W7 = 'E')
      THEN
        BEGIN
          IF NOT EOLN
          THEN 
            READ(W7);
          ProcessFunctionCall
        END;
           
      {�������� �� READ(LN)}
      IF (W4 = 'R') AND (W5 = 'E') AND (W6 = 'A') AND (W7 = 'D')
      THEN
        BEGIN
          IF NOT EOLN
          THEN
            READ(W7);
          IF W7 = 'L'
          THEN
            BEGIN
              IF NOT EOLN
              THEN
                READ(W7);
              IF NOT EOLN
              THEN
                READ(W7);
              WRITE('LN')
            END;
          ProcessFunctionCall
        END;
            
      {�������� �� WRITE(LN)}
      IF (W3 = 'W') AND (W4 = 'R') AND (W5 = 'I') AND (W6 = 'T') AND (W7 = 'E')
      THEN
        BEGIN
          IF NOT EOLN
          THEN
            READ(W7);
          IF W7 = 'L'
          THEN
            BEGIN
              IF NOT EOLN
              THEN
                READ(W7);
              IF NOT EOLN
              THEN
                READ(W7);
              WRITE('LN')
            END;
          ProcessFunctionCall
        END;
      
      {��������� ����������}
      IF W7 = ':'
      THEN
        BEGIN
          IF NOT EOLN
          THEN
            READ(W7); 
          IF NOT EOLN
          THEN
            READ(W7);
          WRITE(' := ');
          WHILE (NOT EOLN) AND (W7 <> ';')
          DO
            BEGIN 
              IF W7 = ''''
              THEN
                ProcessString;
              IF W7 <> ' '
              THEN
                WRITE(W7);
              READ(W7)
            END;
          ProcessSemicolons
        END;
        
      {��������� ������������}
      IF W7 = '{'
      THEN
        BEGIN
          WHILE W7 <> '}'
          DO
            BEGIN
              READ(W7);   
              WRITE(W7)
            END;
          WRITELN;
          WRITE('  ')
        END
    END; 
  WRITELN
END.

