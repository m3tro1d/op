PROGRAM Encryption(INPUT, OUTPUT);
{Переводит символы из INPUT в код согласно Chiper 
 и печатает новые символы в OUTPUT}
CONST
  MaxLength = 20;
  WhitespaceCode = '~';
TYPE        
  LengthType = 1 .. MaxLength;
  Str = ARRAY [LengthType] OF CHAR;
  Chiper = ARRAY ['A' .. 'Z'] OF CHAR;
VAR
  Msg: Str;
  Code: Chiper;
  MsgLength: LengthType;
 
FUNCTION ReadAndEchoMsg(VAR Msg: Str): LengthType;
{Копирование строки из INPUT и эхо ввода; возвращает длину строки}
VAR
  I: LengthType;
BEGIN {ReadAndEchoMsg}
  I := 1;
  WHILE (NOT EOLN) AND (I <= MaxLength)
  DO
    BEGIN
      READ(Msg[I]);
      WRITE(Msg[I]);
      I := I + 1 
    END;
  READLN;
  WRITELN;
  ReadAndEchoMsg := I - 1
END; {ReadAndEchoMsg}
 
PROCEDURE Initialize(VAR Code: Chiper);
{Присвоить Code шифр замены}
BEGIN {Initialize}
  Code['A'] := 'Z';
  Code['B'] := 'Y';
  Code['C'] := 'X';
  Code['D'] := '#';
  Code['E'] := 'V';
  Code['F'] := 'U';
  Code['G'] := 'T';
  Code['H'] := 'S';
  Code['I'] := 'I';
  Code['J'] := 'Q';
  Code['K'] := 'P';
  Code['L'] := '!';
  Code['M'] := 'N';
  Code['N'] := 'M';
  Code['O'] := '2';
  Code['P'] := 'K';
  Code['Q'] := '$';
  Code['R'] := 'D';
  Code['S'] := 'H';
  Code['T'] := '*';
  Code['U'] := 'F';
  Code['V'] := 'E';
  Code['W'] := 'T';
  Code['X'] := 'C';
  Code['Y'] := 'B';
  Code['Z'] := 'A'
END; {Initialize}
 
PROCEDURE Encode(VAR S: Str; VAR Length: LengthType);
{Выводит символы из Code, соответствующие символам из S}
VAR
  Index: LengthType;
BEGIN {Encode}
  FOR Index := 1 TO Length
  DO
    IF S[Index] IN ['A' .. 'Z']
    THEN
      WRITE(Code[S[Index]])
    ELSE
      IF S[Index] = ' '
      THEN
        WRITE(WhitespaceCode)
      ELSE
        WRITE(S[Index]);
  WRITELN
END; {Encode}
 
BEGIN {Encryption}
  {Инициализировать Code}
  Initialize(Code);
  WHILE NOT EOF
  DO
    BEGIN
      {читать строку в Msg и распечатать ее}
      MsgLength := ReadAndEchoMsg(Msg);
      {распечатать кодированное сообщение}
      Encode(Msg, MsgLength)
    END
END. {Encryption}
