PROGRAM SarahRevere(INPUT, OUTPUT); 
VAR
  W1, W2, W3, W4: CHAR;
  Looking, Land, Sea: BOOLEAN; 
 
BEGIN {SarahRevere}   
  {Инициализация}
  W1 := ' ';     
  W2 := ' ';
  W3 := ' ';
  W4 := ' ';
  Looking := TRUE;
  Land := FALSE;
  Sea := FALSE;
  WHILE Looking AND NOT (Land OR Sea)   
  DO
    BEGIN
      {движение окна}
      W1 := W2;
      W2 := W3;
      W3 := W4;
      READ(W4);
      Looking := W4 <> '#';
      WRITELN(W1, W2, W3, W4);
      {проверка окна на land}
      {проверка окна на sea}
    END;
  {создание сообщения Sarah}
END. {SarahRevere} 
