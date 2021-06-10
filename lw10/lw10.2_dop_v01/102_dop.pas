PROGRAM PascalFormatter(INPUT, OUTPUT);
{Программа PascalFormatter: форматирует pascal-программу
 в формате строки BEGIN...END по правилам Coding Conventions
 Хафизов Булат, ПС-13}
VAR
  {Переменные окна}
  W1, W2, W3, W4, W5, W6, W7: CHAR; 
  {EndOccured показывает состояние END. в текущий момент:
   0 - END. еще не встретился;
   1 - END. встретился.}
  EndOccured: CHAR;  
PROCEDURE ProcessSemicolons;
{Процедура ProcessSemicolons: Обрабатывает точки с запятой}
BEGIN   
  {Обработка семиколонов: читаем до тех пор, пока не
   встретим ';' или 'E', т.е. финальный END.}
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
  WRITELN
END;
PROCEDURE ProcessString; 
{Процедура ProcessString: Обрабатывает строковые литералы}
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
{Процедура ProcessFunctionCall: Обрабатывает операторные скобки
 (или их отсутствие)}
BEGIN
  {Игнорируем пробелы перед открывающей скобкой}
  WHILE (NOT EOLN) AND (W7 = ' ')
  DO
    READ(W7); 
  {Если встречена скобка, выводим, игнорируя пробелы и вставляя
   их там, где надо - после запятых}
  IF W7 = '('
  THEN
    BEGIN
      WRITE('(');
      WHILE (NOT EOLN) AND (W7 <> ')')
      DO
        BEGIN
          READ(W7);
          {Обработка строк}
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
  ProcessSemicolons
END;
BEGIN
  {Инициализация}
  W1 := ' ';  
  W2 := ' ';
  W3 := ' ';
  W4 := ' ';
  W5 := ' ';
  W6 := ' ';
  W7 := ' ';
  EndOccured := '0';
  
  {Обработка INPUT:
   W7 при этом иногда находится в состояниии 'detached head'
   (например, в функции ProcessParentheses), но окно постепенно "догоняет"
   W7, поэтому ошибок это не порождает.}
  WHILE (NOT EOLN) AND (EndOccured = '0')
  DO
    BEGIN
      {Движение окна}
      W1 := W2; 
      W2 := W3;
      W3 := W4;
      W4 := W5;
      W5 := W6;
      W6 := W7;
      READ(W7);
      
      {Проверка на BEGIN}
      IF (W3 = 'B') AND (W4 = 'E') AND (W5 = 'G') AND (W6 = 'I') AND (W7 = 'N')
      THEN
        WRITELN('BEGIN');
      
      {Проверка на END.}
      IF (W4 = 'E') AND (W5 = 'N') AND (W6 = 'D') AND (W7 = '.')
      THEN
        BEGIN
          WRITE('END.');
          EndOccured := '1'
        END;
           
      {Проверка на RESET}  
      IF (W3 = 'R') AND (W4 = 'E') AND (W5 = 'S') AND (W6 = 'E') AND (W7 = 'T')
      THEN
        BEGIN
          WRITE('  RESET');
          IF NOT EOLN
          THEN 
            READ(W7);
          ProcessFunctionCall 
        END;
           
      {Проверка на REWRITE}  
      IF (W1 = 'R') AND (W2 = 'E') AND (W3 = 'W') AND (W4 = 'R') AND (W5 = 'I') AND (W6 = 'T') AND (W7 = 'E')
      THEN
        BEGIN
          WRITE('  REWRITE');
          IF NOT EOLN
          THEN 
            READ(W7);
          ProcessFunctionCall
        END;
           
      {Проверка на READ(LN)}
      IF (W4 = 'R') AND (W5 = 'E') AND (W6 = 'A') AND (W7 = 'D')
      THEN
        BEGIN
          WRITE('  READ');
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
            
      {Проверка на WRITE(LN)}
      IF (W3 = 'W') AND (W4 = 'R') AND (W5 = 'I') AND (W6 = 'T') AND (W7 = 'E')
      THEN
        BEGIN
          WRITE('  WRITE');
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
      
      {Обработка присвоения}
      IF W7 = ':'
      THEN
        BEGIN
          IF NOT EOLN
          THEN
            READ(W7); 
          IF NOT EOLN
          THEN
            READ(W7);
          WRITE('  := ');
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
        
      {Обработка комментариев}
      IF W7 = '{'
      THEN
        BEGIN
          WRITE('  ');
          WHILE W7 <> '}'
          DO
            BEGIN
              WRITE(W7);
              READ(W7)
            END;
          WRITELN('}')
        END
    END; 
  WRITELN
END.

