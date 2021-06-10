PROGRAM XPrint(INPUT, OUTPUT);
{ Псевдографическая печать строки символов }
CONST
  MatrixStart = 1;
  MatrixSize = 5;
  MatrixEnd = MatrixSize * MatrixSize;
  FillerCharacter = 'X';
  BlankCharacter = ' ';
  AlphabetFilename = 'symbols.txt';
  MaxLineLength = 10;

TYPE
  CharacterMatrix = SET OF MatrixStart..MatrixEnd;
  LineMatrix = SET OF MatrixStart..MatrixEnd * MaxLineLength;
  AlphabetType = ARRAY [CHAR] OF CharacterMatrix;
  CharDomain = SET OF CHAR;

VAR
  AlphabetFile: TEXT;
  Alphabet: AlphabetType;
  AlphabetDomain: CharDomain;
  PseudoLine: LineMatrix;
  LineLength: INTEGER;

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

PROCEDURE ReadAlphabet(VAR AlphabetFile: TEXT; VAR Alphabet: AlphabetType; VAR AlphabetDomain: CharDomain);
{ Считывание алфавита из файла }
VAR
  CurrentChar: CHAR;
  CurrentMatrix: CharacterMatrix;
BEGIN {ReadAlphabet}
  ASSIGN(AlphabetFile, AlphabetFilename);
  RESET(AlphabetFile);
  AlphabetDomain := [];
  WHILE NOT EOF(AlphabetFile)
  DO
    BEGIN
      READ(AlphabetFile, CurrentChar);
      READLN(AlphabetFile);
      ReadPseudoCharacter(AlphabetFile, CurrentMatrix);
      Alphabet[CurrentChar] := CurrentMatrix;
      AlphabetDomain := AlphabetDomain + [CurrentChar]
    END;
  CLOSE(AlphabetFile)
END; {ReadAlphabet}

PROCEDURE FindSymbol(VAR Alph: AlphabetType; VAR AlphabetDomain: CharDomain; VAR Ch: CHAR; VAR M: CharacterMatrix);
{ Поиск нужного символа в алфавите; если такого нет, возвращается пробел }
VAR
  Index: INTEGER;
BEGIN {FindSymbol}
  M := [];
  IF Ch IN AlphabetDomain
  THEN
    M := Alph[Ch]
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
          { Смещение элементов матрицы по символам }
          NewIndex := Index + (MatrixEnd * OrderIndex);
          L := L + [NewIndex]
        END
    END
END; {AddMatrix}

FUNCTION ReadPseudoLine(VAR FIn: TEXT; VAR Alph: AlphabetType; VAR AlphabetDomain: CharDomain; VAR L: LineMatrix): INTEGER;
{ Копирование строки из файла в псевдографическое представление; возвращает длину строки }
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
      FindSymbol(Alph, AlphabetDomain, Ch, CurrentMatrix);
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
      FOR CharIndex := 0 TO Len - 1
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
  ReadAlphabet(AlphabetFile, Alphabet, AlphabetDomain);
  LineLength := ReadPseudoLine(INPUT, Alphabet, AlphabetDomain, PseudoLine);
  PrintPseudoLine(OUTPUT, PseudoLine, LineLength);
  WRITELN(OUTPUT)
END. {XPrint}
