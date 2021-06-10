UNIT Morphology;
{Morphology: ������, ��������������� ��������
 ���������������� ������� �����}
INTERFACE
USES WordReader;

PROCEDURE SliceWord(VAR Word, Base, Ending: WordType); {������ ����� �� ������ + ���������}


IMPLEMENTATION
CONST
  EndingsAmount = 46;
  Endings: ARRAY [1 .. EndingsAmount] OF WordType = ('���', '���', '���', '���', '���', '���', '���', '���', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '��', '�', '�', '�', '�', '�', '�', '�', '�', '�');

FUNCTION ReverseString(Str: WordType): WordType;
{ReverseString: ���������� ��������������� ������}
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
{ReversePos: ���������� ������ ������� ��������� Pattern � ������}
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
{IsEnding: ���������� TRUE, ���� ��������� �������� �����}
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
{SliceWord: ������� ��������� ��������� � ������� ����������� + ���������� ������}
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
