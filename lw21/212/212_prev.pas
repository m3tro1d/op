PROGRAM XPrint(INPUT, OUTPUT);
{ Псевдографическая печать строки символов }
CONST
  MatrixStart = 1;
  MatrixSize = 5;
  MatrixEnd = MatrixSize * MatrixSize;
  FillerCharacter = 'X';
  BlankCharacter = ' ';
  MaxAlphabetSize = 256;
  AlphabetFilename = 'symbols.txt';
  MaxLineLength = 10;

TYPE
  CharacterMatrix = SET OF MatrixStart..MatrixEnd;
  LineMatrix = SET OF MatrixStart..MatrixEnd * MaxLineLength;
  AlphabetEntry = RECORD
                    Character: CHAR;
                    Matrix: CharacterMatrix
                  END;
  AlphabetType = ARRAY [1..MaxAlphabetSize] OF AlphabetEntry;

VAR
  AlphabetFile: TEXT;
  Alphabet: AlphabetType;
  AlphabetLen: INTEGER;
  PseudoLine: LineMatrix;
  LineLength: INTEGER;
  Index: INTEGER;

PROCEDURE ReadPseudoCharacter(VAR FIn: TEXT; VAR M: CharacterMatrix);
{ Считывание псевдографического символа из файла }
VAR
  Index: MatrixStart..MatrixEnd;
  Ch: CHAR;
BEGIN {ReadPseudoCharacter}
  M := [];
  FOR Index := MatrixStart TO MatrixEnd
  DO
    BEGIN
      READ(FIn, Ch);
      IF Ch = FillerCharacter
      THEN
        M := M + [Index];
      IF Index MOD MatrixSize = 0
      THEN
        READLN(FIn)
    END
END; {ReadPseudoCharacter}

FUNCTION ReadAlphabet(VAR AlphabetFile: TEXT; VAR Alphabet: AlphabetType): INTEGER;
{ Считывание алфавита из файла }
VAR
  CurrentScope: AlphabetEntry;
  Index: 1..MaxAlphabetSize;
BEGIN {ReadAlphabet}
  ASSIGN(AlphabetFile, AlphabetFilename);
  RESET(AlphabetFile);
  Index := 1;
  WHILE (NOT EOF(AlphabetFile)) AND (Index <= MaxAlphabetSize)
  DO
    BEGIN
      READ(AlphabetFile, CurrentScope.Character);
      READLN(AlphabetFile);
      ReadPseudoCharacter(AlphabetFile, CurrentScope.Matrix);
      Alphabet[Index] := CurrentScope;
      Index := Index + 1
    END;
  ReadAlphabet := Index - 1
END; {ReadAlphabet}

PROCEDURE FindSymbol(VAR Alph: AlphabetType; VAR AlphLen: INTEGER; VAR Ch: CHAR; VAR M: CharacterMatrix);
{ Поиск нужного символа в алфавите; если такого нет, возвращается пробел }
VAR
  Index: INTEGER;
BEGIN {FindSymbol}
  M := [];
  FOR Index := 1 TO AlphLen
  DO
    BEGIN
      IF Alph[Index].Character = Ch
      THEN
        BEGIN
          M := Alph[Index].Matrix;
          BREAK
        END
    END
END; {FindSymbol}

PROCEDURE AddMatrix(VAR L: LineMatrix; M: CharacterMatrix; VAR OrderIndex: INTEGER);
{ Добавить порядковый символ в псевдографическую строку }
VAR
  Index: MatrixStart..MatrixEnd;
  NewIndex: MatrixStart..MatrixEnd * MaxLineLength;
BEGIN {AddMatrix}
  FOR Index := MatrixStart TO MatrixEnd
  DO
    BEGIN
      IF Index IN M
      THEN
        BEGIN
          NewIndex := Index + (MatrixEnd * OrderIndex);
          L := L + [NewIndex]
        END
    END
END; {AddMatrix}

FUNCTION ReadPseudoLine(VAR FIn: TEXT; VAR Alph: AlphabetType; VAR AlphLen: INTEGER; VAR L: LineMatrix): INTEGER;
{ Копирование строки из файла в псевдографическое представление }
VAR
  CharIndex: INTEGER;
  Ch: CHAR;
  CurrentMatrix: CharacterMatrix;
BEGIN {ReadPseudoLine}
  CharIndex := 0;
  L := [];
  WHILE (NOT EOLN(FIn)) AND (CharIndex < MaxLineLength)
  DO
    BEGIN
      READ(FIn, Ch);
      FindSymbol(Alph, AlphLen, Ch, CurrentMatrix);
      AddMatrix(L, CurrentMatrix, CharIndex);
      CharIndex := CharIndex + 1
    END;
  ReadPseudoLine := CharIndex
END; {ReadPseudoLine}

PROCEDURE PrintPseudoLine(VAR FOut: TEXT; VAR L: LineMatrix; Len: INTEGER);
{ Копирование строки в псевдографике в файл }
VAR
  RowIndex: INTEGER;
  ColumnIndex: INTEGER;
  CharIndex: INTEGER;
BEGIN {PrintPseudoLine}
  FOR RowIndex := MatrixStart TO MatrixSize
  DO
    BEGIN
      FOR CharIndex := 0 TO Len
      DO
        BEGIN
          ColumnIndex := (MatrixSize * RowIndex) - (MatrixSize - 1) + (CharIndex * MatrixEnd);
          WHILE ColumnIndex <= (MatrixSize * RowIndex) + (CharIndex * MatrixEnd)
          DO
            BEGIN
              IF ColumnIndex IN L
              THEN
                WRITE(FOut, FillerCharacter)
              ELSE
                WRITE(FOut, BlankCharacter);
              ColumnIndex := ColumnIndex + 1
            END;
          WRITE(FOut, BlankCharacter)
        END;
      WRITELN(FOut)
    END
END; {PrintPseudoLine}

BEGIN {XPrint}
  AlphabetLen := ReadAlphabet(AlphabetFile, Alphabet);
  CLOSE(AlphabetFile);
  LineLength := ReadPseudoLine(INPUT, Alphabet, AlphabetLen, PseudoLine);
  PrintPseudoLine(OUTPUT, PseudoLine, LineLength);
  WRITELN(OUTPUT)
END. {XPrint}
