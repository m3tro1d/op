PROGRAM SarahRevere(INPUT, OUTPUT);
{Печать сообщения о том как идут британцы, в зависимости
 от того, первым во входе встречается 'land', 'sea'.}
VAR
  Looking: CHAR;

PROCEDURE InitWindow(VAR W1, W2, W3, W4: CHAR);
BEGIN {InitWindow}
  W1 := ' ';
  W2 := ' ';
  W3 := ' ';
  W4 := ' '
END; {InitWindow}

PROCEDURE MoveWindow(VAR F: TEXT; VAR W1, W2, W3, W4, Looking: CHAR);
BEGIN {MoveWindow}
  W1 := W2;
  W2 := W3;
  W3 := W4;
  READ(F, W4);
  IF W4 = '#'
  THEN
    Looking := 'N'
END; {MoveWindow}

PROCEDURE CheckLand(VAR W1, W2, W3, W4, Looking: CHAR);
BEGIN {CheckLand}
  IF (W1 = 'l') AND (W2 = 'a') AND (W3 = 'n') AND (W4 = 'd')
  THEN
    Looking := 'L'
END; {CheckLand}

PROCEDURE CheckSea(VAR W1, W2, W3, W4, Looking: CHAR);
BEGIN {CheckSea}
  IF (W2 = 's') AND (W3 = 'e') AND (W4 = 'a')
  THEN
    Looking := 'S'
END; {CheckSea}

PROCEDURE FindWord(VAR F: TEXT; VAR Looking: CHAR);
{FindWord: устанавливает значение Looking в зависимости
 от найденного слова: L, S, A; Y - не найдено}
VAR
  W1, W2, W3, W4: CHAR;
BEGIN {FindWord}
  InitWindow(W1, W2, W3, W4);
  Looking := 'Y';
  WHILE (Looking = 'Y') AND (NOT EOLN(F))
  DO
    BEGIN
      MoveWindow(F, W1, W2, W3, W4, Looking);
      CheckLand(W1, W2, W3, W4, Looking);
      CheckSea(W1, W2, W3, W4, Looking)
    END
END; {FindWord}

PROCEDURE PrintLooking(VAR Looking: CHAR);
{PrintLooking: выводит сообщение, соответствующее
 значению Looking}
BEGIN {PrintLooking}
  IF Looking = 'L'
  THEN
    WRITELN('The British are coming by land.')
  ELSE
    IF Looking = 'S'
    THEN
      WRITELN('The British coming by sea.')
    ELSE
      WRITELN('Sarah didn''t say.')
END; {PrintLooking}

BEGIN {SarahRevere}
  FindWord(INPUT, Looking);
  PrintLooking(Looking)
END. {SarahRevere}
