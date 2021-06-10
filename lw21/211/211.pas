PROGRAM PseudoGraphics(INPUT, OUTPUT);
{Псевдографическая печать символов}
CONST
  MatrixStart = 1;
  MatrixSize = 5;
  MatrixEnd = MatrixSize * MatrixSize;
  FillerCharacter = 'X';
  BlankCharacter = ' ';

TYPE
  CharacterMatrix = SET OF MatrixStart..MatrixEnd;
  
VAR
  Ch: CHAR;
  
FUNCTION SelectCharacterMatrix(VAR M: CharacterMatrix; VAR Ch: CHAR): BOOLEAN;
{Выбирает матрицу символа и возвращает TRUE, если такой символ есть; иначе FALSE}
BEGIN {SelectCharacterMatrix}
  SelectCharacterMatrix := TRUE;
  CASE Ch OF
    {Буквы}
    'A': M := [1, 2, 3, 4, 5, 6, 10, 11, 12, 13, 14, 15, 16, 20, 21, 25];
    'M': M := [1, 5, 6, 7, 9, 10, 11, 13, 15, 16, 20, 21, 25]; 
    'N': M := [1, 5, 6, 7, 10, 11, 13, 15, 16, 19, 20, 21, 25];
    'Z': M := [1, 2, 3, 4, 5, 9, 13, 17, 21, 22, 23, 24, 25];
    {Цифры}
    '0': M := [1, 2, 3, 4, 5, 6, 10, 11, 15, 16, 20, 21, 22, 23, 24, 25];
    '1': M := [3, 7, 8, 11, 13, 18, 23];
    {Символы}
    '+': M := [8, 11, 12, 13, 14, 15, 18];
    '-': M := [11, 12, 13, 14, 15];
    '=': M := [6, 7, 8, 9, 10, 16, 17, 18, 19, 20];
    ' ': M := [];
    ELSE SelectCharacterMatrix := FALSE
  END
END; {SelectCharacterMatrix}

PROCEDURE PrintCharacter(VAR FOut: TEXT; VAR Character: CHAR);
{PrintCharacter: выводит символ в файл в псевдографике}
VAR
  Matrix: CharacterMatrix;
  Index: INTEGER;
BEGIN {PrintCharacter}
  IF SelectCharacterMatrix(Matrix, Character)
  THEN
    FOR Index := MatrixStart TO MatrixEnd
    DO
      BEGIN
        IF Index IN Matrix
        THEN
          WRITE(FOut, FillerCharacter)
        ELSE
          WRITE(FOut, BlankCharacter);
        IF Index MOD MatrixSize = 0
        THEN
          WRITELN(FOut)
      END
END; {PrintCharacter}

BEGIN {PseudoGraphics}
  IF NOT EOLN(INPUT)
  THEN
    BEGIN
      READ(Ch);
      PrintCharacter(OUTPUT, Ch);
      WRITELN(OUTPUT)
    END
END. {PseudoGraphics}
