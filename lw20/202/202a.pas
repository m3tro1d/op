PROGRAM DateUtilsTest(INPUT, OUTPUT);
USES DateUtils;
VAR
  D1, D2: Date;
  F: FileOfDate;
BEGIN   
  {Тестирование операций с датами}
  ReadDate(INPUT, D1);
  READLN(INPUT);
  ReadDate(INPUT, D2);
  WRITE(OUTPUT, 'Is ');
  WriteDate(OUTPUT, D1);
  WRITE(OUTPUT, ' less than '); 
  WriteDate(OUTPUT, D2);
  WRITE(OUTPUT, ': ');
  WRITELN(OUTPUT, Less(D1, D2));
  WRITELN;
  {Тестирование CopyOut}
  REWRITE(F);
  WRITE(F, D1);
  WRITE(F, D2);
  RESET(F);
  CopyOut(F)
END.
