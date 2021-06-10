PROGRAM GroupWords(INPUT, OUTPUT);
{GroupWords: группировка однокоренных слов в файле формата CountWords}
USES
  Statistics;

CONST
  StatisticsFilename = 'stat_grouped.txt';

VAR
  StatisticsFile: TEXT;

BEGIN {GroupWords}
  GroupWords(INPUT);
  ASSIGN(StatisticsFile, StatisticsFilename);
  REWRITE(StatisticsFile);
  PrintStatistics(StatisticsFile)
END. {GroupWords}
