PROGRAM SortMonth(INPUT, OUTPUT);
USES DateIO;
VAR
  M1, M2: Month;
BEGIN {SortMonth}
  ReadMonth(INPUT, M1);
  ReadMonth(INPUT, M2);
  {�������� M1 � M2, ������� ���������}
  WriteMonth(OUTPUT, M1);
  WriteMonth(OUTPUT, M2);
  WRITELN
END. {SortMonth}
