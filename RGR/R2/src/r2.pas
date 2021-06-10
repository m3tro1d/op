PROGRAM CountWords(INPUT, OUTPUT);
{CountWords: ������� ���������� ������������� ����.
 ��������� ������� ������: Windows 1251}
USES
  WordReader, WordTree, FileDistributor;

CONST
  StatisticsFilename = 'stat.txt';

VAR
  Root: Tree;
  StatisticsFile: TEXT;

PROCEDURE ProcessInput(VAR Root: Tree);
{ProcessInput: ���������� ������}
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
          InsertWordWithMemoryCheck(Root, CurrentWord)
      END
    ELSE
      READLN(INPUT);
  FlushTree(Root)
END; {ProcessInput}

PROCEDURE PrintStatistics(VAR StatFile: TEXT);
{PrintStatistics: �������� ����� � ����� ������}
BEGIN {PrintStatistics}
  ASSIGN(StatFile, StatisticsFilename);
  REWRITE(StatFile);
  PrintTreeFile(StatFile)
END; {PrintStatistics}

BEGIN {CountWords}
  ProcessInput(Root);
  PrintStatistics(StatisticsFile);
  CLOSE(StatisticsFile)
END. {CountWords}
