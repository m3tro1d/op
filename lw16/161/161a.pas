PROGRAM Count(INPUT, OUTPUT);
{CountReverse: подсчет реверсов в строке INPUT}
USES Count3;
VAR
  IsOverflow: CHAR;
  V100, V10, V1: CHAR;

PROCEDURE CheckOverflow(VAR Flag, V100, V10, V1: CHAR);
{CheckOverflow: проверка переполнения счетчика}
BEGIN {CheckOverflow}
  Flag := '0';
  IF (V100 = '9') AND (V10 = '9') AND (V1 = '9')
  THEN
    Flag := '1'
END; {CheckOverflow}                         

BEGIN {Count}
  Start;
  Value(V100, V10, V1);
  WRITELN(V100, V10, V1);
  CheckOverflow(IsOverflow, V100, V10, V1);
  WHILE IsOverflow = '0'
  DO
    BEGIN
      Bump;
      Value(V100, V10, V1);
      WRITELN(V100, V10, V1);
      CheckOverflow(IsOverflow, V100, V10, V1)
    END
END. {Count}
