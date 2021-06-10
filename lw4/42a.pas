PROGRAM SarahRevere(INPUT, OUTPUT);
{Печать сообщения о том как идут британцы, в зависимости
от того, первым во входе встречается 'land' или 'sea'.}
VAR
  W1, W2, W3, W4, Looking: CHAR;
BEGIN {SarahRevere}
  {инициализация W1,W2,W3,W4,Looking}
  W1 := ' ';
  W2 := ' ';
  W3 := ' ';
  W4 := ' ';
  Looking := 'Y';
  WHILE Looking = 'Y'
  DO
    BEGIN
      { Двигать окно, проверять конец данных}
      W1 := W2;
      W2 := W3;
      W3 := W4;
      READ(W4);
      IF W4 = '#'
      THEN {Конец данных}
        Looking := 'N';
      { Проверка окна }
      WRITE(W1, W2, W3, W4);
      {Выводить запятую, если окно не последнее}
      IF W4 <> '#'
      THEN
        WRITE(', ')
      { Проверка окна для  'land'}
      { Проверка окна для 'sea'}
    END;
  WRITELN
  {создать сообщение Sarah}
END. {SarahRevere}
