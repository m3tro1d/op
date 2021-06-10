PROGRAM GroupWords(INPUT, OUTPUT);
{GroupWords: группировка однокоренных слов в файле формата CountWords}
USES
  WordReader, Morphology, Container;

CONST
  StatisticsFilename = 'stat_grouped.txt';

VAR
  StatisticsFile: TEXT;

PROCEDURE GroupWordsFromInput;
{GroupWordsFromInput: чтение статистики из INPUT и заполнение контейнера}
VAR
  CurrentWord, CurrentBase, CurrentEnding: WordType;
  CurrentAmount: INTEGER;
  CurrentItem: ItemType;
BEGIN {GroupWordsFromInput}
  ClearItem(CurrentItem);
  WHILE NOT EOF(INPUT)
  DO
    BEGIN
      ReadWord(INPUT, CurrentWord);
      READLN(CurrentAmount);
      SliceWord(CurrentWord, CurrentBase, CurrentEnding);
      IF CurrentItem.Base <> ''
      THEN
        IF CurrentItem.Base = CurrentBase
        THEN
          BEGIN
            CurrentItem.Amount := CurrentItem.Amount + CurrentAmount;
            AddEnding(CurrentItem, CurrentEnding)
          END
        ELSE
          BEGIN
            AddItem(CurrentItem);
            ClearItem(CurrentItem);
            CurrentItem.Amount := CurrentAmount;
            CurrentItem.Base := CurrentBase;
            AddEnding(CurrentItem, CurrentEnding)
          END
      ELSE
        BEGIN
          CurrentItem.Base := CurrentBase;
          CurrentItem.Amount := CurrentAmount;
          AddEnding(CurrentItem, CurrentEnding)
        END
    END;
  AddItem(CurrentItem)
END; {GroupWordsFromInput}

PROCEDURE PrintStatistics;
{PrintStatistics: подготовка файла и вывод статистики контейнера}
VAR
  StatisticsFile: TEXT;
BEGIN {PrintStatistics}
  ASSIGN(StatisticsFile, StatisticsFilename);
  REWRITE(StatisticsFile);
  PrintContainer(StatisticsFile);
  CLOSE(StatisticsFile)
END; {PrintStatistics}

BEGIN {GroupWords}
  GroupWordsFromInput;
  PrintStatistics
END. {GroupWords}
