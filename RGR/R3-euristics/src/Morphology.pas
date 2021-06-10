UNIT Morphology;
{Morphology: модуль, предоставляющий средства
 морфологического анализа слова}
INTERFACE
USES WordReader;

PROCEDURE SliceWord(VAR Word, Base, Ending: WordType); {Разбор слова на основу + окончание}


IMPLEMENTATION
CONST
  EndingsAmount = 46;
  Endings: ARRAY [1 .. EndingsAmount] OF WordType = ('ями', 'ыми', 'ому', 'ого', 'ими', 'ему', 'его', 'ами', 'ам', 'ах', 'ая', 'ев', 'ее', 'ей', 'ем', 'ец', 'ие', 'ии', 'ий', 'им', 'их', 'ов', 'ое', 'ой', 'ом', 'ою', 'ую', 'ца', 'ые', 'ый', 'ым', 'ых', 'ью', 'юю', 'ям', 'ях', 'яя', 'а', 'е', 'и', 'о', 'у', 'ы', 'ь', 'ю', 'я');

FUNCTION ReverseString(Str: WordType): WordType;
{ReverseString: возвращает реверсированную строку}
VAR
  Reversed: WordType;
  Index: INTEGER;
BEGIN {ReverseString}
  Reversed := '';
  FOR Index := LENGTH(Str) DOWNTO 1
  DO
    Reversed := Reversed + Str[Index];
  ReverseString := Reversed
END; {ReverseString}

FUNCTION ReversePos(Pattern, Word: WordType): INTEGER;
{ReversePos: возвращает индекс первого вхождения Pattern в строке}
VAR
  WordLen, PatternLen: INTEGER;
  ReversedWord, ReversedPattern: WordType;
BEGIN {ReversePos}
  ReversedWord := ReverseString(Word);
  ReversedPattern := ReverseString(Pattern);
  WordLen := LENGTH(Word);
  PatternLen := LENGTH(Pattern);
  ReversePos := 0;
  IF POS(ReversedPattern, ReversedWord) = 1
  THEN
    ReversePos := WordLen - PatternLen + 1
  ELSE
    IF POS(Pattern, Word) <> 0
    THEN
      ReversePos := WordLen - POS(ReversedPattern, ReversedWord) - 1
END; {ReversePos}

FUNCTION IsEnding(VAR Word: WordType; Ending: WordType): BOOLEAN;
{IsEnding: возвращает TRUE, если окончание подходит слову}
VAR
  WordLen, EndingLen: INTEGER;
  ActualPos, EstimatedPos: INTEGER;
BEGIN {IsEnding}
  WordLen := LENGTH(Word);
  EndingLen := LENGTH(Ending);
  ActualPos := ReversePos(Ending, Word);
  EstimatedPos := WordLen - EndingLen + 1;
  IsEnding := (ActualPos <> 0) AND (WordLen > EndingLen) AND (ActualPos = EstimatedPos)
END; {IsEnding}

PROCEDURE SliceWord(VAR Word, Base, Ending: WordType);
{SliceWord: перебор возможных окончаний и возврат подходящего + оставшейся основы}
VAR
  Index, SlicePosition: INTEGER;
BEGIN {SliceWord}
  Base := '';
  Ending := '';
  FOR Index := 1 TO EndingsAmount
  DO
    BEGIN
      IF IsEnding(Word, Endings[Index])
      THEN
        BEGIN
          SlicePosition := ReversePos(Endings[Index], Word);
          Base := COPY(Word, 1, SlicePosition - 1);
          Ending := COPY(Word, SlicePosition, LENGTH(Word));
          BREAK
        END
    END;
  IF Ending = ''
  THEN
    Base := Word
END; {SliceWord}

BEGIN {Morphology}
END. {Morphology}
