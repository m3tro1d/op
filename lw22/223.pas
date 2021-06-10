PROGRAM Decryption(INPUT, OUTPUT);
{��������� ��� �� INPUT � ������� �������� Chiper 
 � �������� ����� ������� � OUTPUT}
CONST
  MaxLength = 20;
  WhitespaceCode = '~';
  CodeFilename = 'code.txt';
TYPE        
  LengthType = 1 .. MaxLength;
  Str = ARRAY [LengthType] OF CHAR;
  Chiper = ARRAY [CHAR] OF CHAR;
  ChiperDomainRange = SET OF CHAR;
VAR       
  Code: Chiper;
  RetrievedKeys, RetrievedCodes: ChiperDomainRange;
  Msg: Str;
  MsgLength: LengthType;
 
FUNCTION ReadAndEchoMsg(VAR Msg: Str): LengthType;
{����������� ������ �� INPUT � ��� �����; ���������� ����� ������}
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
 
FUNCTION Initialize(VAR Code: Chiper; VAR RetrievedKeys, RetrievedCodes: ChiperDomainRange): BOOLEAN;
{��������� Code ���� ������; ���������� TRUE, ���� ������������� ������ �������}
VAR
  CodeFile: TEXT;
  KeyChar, CodeChar: CHAR;
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
          Code[CodeChar] := KeyChar;
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

PROCEDURE Decode(VAR Code: Chiper; VAR Codes: ChiperDomainRange; VAR S: Str; VAR Length: LengthType);
{������� ������� �� Code, ��������������� �������������� �������� �� S}
VAR
  Index: LengthType;
  Key: CHAR;
BEGIN {Encode}
  FOR Index := 1 TO Length
  DO
    IF S[Index] IN Codes
    THEN
      WRITE(Code[S[Index]])
    ELSE
      WRITE(S[Index]);
  WRITELN
END; {Encode}
 
BEGIN {Decryption}
  {���������������� Code}
  IF Initialize(Code, RetrievedKeys, RetrievedCodes)
  THEN
    WHILE NOT EOF
    DO
      BEGIN
        {������ ������ � Msg � ����������� ��}
        MsgLength := ReadAndEchoMsg(Msg);
        {����������� ������������ ���������}
        Decode(Code, RetrievedCodes, Msg, MsgLength)
      END
  ELSE
    WRITELN('Initialization error')
END. {Decryption}
