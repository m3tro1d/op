PROGRAM Encryption(INPUT, OUTPUT);
{Переводит символы из INPUT в код согласно Chiper 
 и печатает новые символы в OUTPUT}
CONST
  MaxLength = 20;
  CodeFilename = 'code.txt';
TYPE        
  LengthType = 1 .. MaxLength;
  Str = ARRAY [LengthType] OF CHAR;
  Chiper = ARRAY [CHAR] OF CHAR;
  ChiperDomainRange = SET OF CHAR;
VAR       
  Code: Chiper;
  RetrievedKeys: ChiperDomainRange;
  Msg: Str;
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
 
FUNCTION Initialize(VAR Code: Chiper; VAR RetrievedKeys: ChiperDomainRange): BOOLEAN;
{Присвоить Code шифр замены; возвращает TRUE, если инициализация прошла успешно}
VAR
  CodeFile: TEXT;
  KeyChar, CodeChar: CHAR;
  RetrievedCodes: ChiperDomainRange;
  IsAlright: BOOLEAN;
BEGIN {Initialize}
  ASSIGN(CodeFile, CodeFilename);
  RESET(CodeFile);   
  IsAlright := TRUE;
  RetrievedKeys := [];
  RetrievedCodes := [];
  WHILE NOT EOF(CodeFile) AND IsAlright
  DO
    BEGIN
      IF NOT EOLN(CodeFile)
      THEN
        READ(CodeFile, KeyChar)
      ELSE
        IsAlright := FALSE;
      IF NOT EOLN(CodeFile)
      THEN
        READ(CodeFile, CodeChar)
      ELSE
        IsAlright := FALSE;
      IF NOT (KeyChar IN RetrievedKeys) AND NOT (CodeChar IN RetrievedCodes)
      THEN
        BEGIN
          Code[KeyChar] := CodeChar;
          RetrievedKeys := RetrievedKeys + [KeyChar];
          RetrievedCodes := RetrievedCodes + [CodeChar]
        END
      ELSE
        IsAlright := FALSE;
      READLN(CodeFile)
    END;
  CLOSE(CodeFile);
  Initialize := IsAlright
END; {Initialize}
 
PROCEDURE Encode(VAR Code: Chiper; VAR Keys: ChiperDomainRange; VAR S: Str; VAR Length: LengthType);
{Выводит символы из Code, соответствующие символам из S}
VAR
  Index: LengthType;
BEGIN {Encode}
  FOR Index := 1 TO Length
  DO
    IF S[Index] IN Keys
    THEN
      WRITE(Code[S[Index]])
    ELSE
      WRITE(S[Index]);
  WRITELN
END; {Encode}
 
BEGIN {Encryption}
  {Инициализировать Code}
  IF Initialize(Code, RetrievedKeys)
  THEN
    WHILE NOT EOF
    DO
      BEGIN
        {читать строку в Msg и распечатать ее}
        MsgLength := ReadAndEchoMsg(Msg);
        {распечатать кодированное сообщение}
        Encode(Code, RetrievedKeys, Msg, MsgLength)
      END
  ELSE
    WRITELN('Initialization error')
END. {Encryption}
