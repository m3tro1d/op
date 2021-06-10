PROGRAM CountReverse(INPUT, OUTPUT);
{CountReverse: подсчет реверсов в строке INPUT}
USES Count3;
VAR
  Prev, Curr, Next: CHAR;
  IsOverflow, IsReverse: CHAR;
  V100, V10, V1: CHAR;

PROCEDURE CheckReverse(VAR Flag, Ch1, Ch2, Ch3: CHAR);
{CheckReverse: устанавливает Flag в T, если Ch1, Ch2, Ch3
 является реверсом, иначе F}
BEGIN {CheckReverse}
  Flag := '0';
  IF ((Ch2 > Ch1) AND (Ch2 > Ch3)) OR ((Ch2 < Ch1) AND (Ch2 < Ch3))
  THEN
    Flag := '1'
END; {CheckReverse}

PROCEDURE CheckOverflow(VAR Flag, V100, V10, V1: CHAR);
{CheckOverflow: проверка переполнения счетчика}
BEGIN {CheckOverflow}
  Flag := '0';
  IF (V100 = '9') AND (V10 = '9') AND (V1 = '9')
  THEN
    Flag := '1'
END; {CheckOverflow}

BEGIN {CountReverse}
  Start;
  CheckOverflow(IsOverflow, V100, V10, V1);
  WRITE('Вход:');

  {Удостовериться, что в INPUT как минимум 3 символа}
  IF NOT EOLN(INPUT)
  THEN
    BEGIN
      READ(Next);
      WRITE(Next)
    END;
  IF NOT EOLN(INPUT)
  THEN
    BEGIN
      Curr := Next;
      READ(Next);
      WRITE(Next)
    END;

  WHILE NOT (EOLN(INPUT) OR (IsOverflow = '1'))
  DO
    BEGIN
      Prev := Curr;
      Curr := Next;
      READ(INPUT, Next);
      WRITE(OUTPUT, Next);
      CheckReverse(IsReverse, Prev, Curr, Next);
      IF IsReverse = '1'
      THEN
        Bump;
      CheckOverflow(IsOverflow, V100, V10, V1)
    END;
  WRITELN;

  IF IsOverflow = '0'
  THEN
    WRITE(OUTPUT, 'Количество реверсов:')
  ELSE
    WRITE(OUTPUT, 'Переполнение! Количество реверсов как минимум:');
  Value(V100, V10, V1);
  WRITELN(V100, V10, V1)
END. {CountReverse}
