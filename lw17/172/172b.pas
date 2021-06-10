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
      {проверка окна на land}        
      Land := (W1 = 'l') AND (W2 = 'a') AND (W3 = 'n') AND (W4 = 'd'); 
      {проверка окна на sea}
      Sea := (W1 = 's') AND (W2 = 'e') AND (W3 = 'a')
    END;
  WRITELN('Land: ', Land, '; Sea: ', Sea);
  {создание сообщения Sarah}
END. {SarahRevere} 
