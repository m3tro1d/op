PROGRAM CountWords(INPUT, OUTPUT);
{CountWords: подсчет статистики встречающихся слов.
 Кодировка входных файлов: Windows 1251}
USES
  WordReader, WordTree;

CONST
  StatisticsFilename = 'stat.txt';

VAR
  Root: Tree;
  StatisticsFile: TEXT;

PROCEDURE ProcessInput(VAR Root: Tree);
{ProcessInput: заполнение дерева}
VAR
  CurrentWord: WordType;
BEGIN {ProcessInput}
  Root := NIL;
  WHILE NOT EOF(INPUT)
  DO
    IF NOT EOLN(INPUT)
    THEN
      BEGIN
        ReadWord(INPUT, CurrentWord);
        IF CurrentWord <> ''
        THEN
          InsertWord(Root, CurrentWord)
      END
    ELSE
      READLN(INPUT)
END; {ProcessInput}

PROCEDURE PrintStatistics(VAR Root: Tree; VAR StatFile: TEXT);
{PrintStatistics: открытие файла и вывод дерева}
BEGIN {PrintStatistics}
  ASSIGN(StatFile, StatisticsFilename);
  REWRITE(StatFile);
  PrintWordTree(StatFile, Root)
END; {PrintStatistics}

PROCEDURE CleanUp(VAR Root: Tree; VAR StatFile: TEXT);
{CleanUp: освобождение памяти}
BEGIN {CleanUp}
  DisposeTree(Root);
  CLOSE(StatFile)
END; {CleanUp}

BEGIN {CountWords}
  ProcessInput(Root);
  PrintStatistics(Root, StatisticsFile);
  CleanUp(Root, StatisticsFile)
END. {CountWords}
