PROGRAM Prime(INPUT, OUTPUT);
{���������� ������� ����� � ��������� �� 2 �� 100}
CONST
  LowerBound = 2;
  UpperBound = 100;
  
VAR
  Sieve: SET OF LowerBound..UpperBound;
  CurrentNumber, Multiplier: INTEGER;
  
BEGIN              
  Sieve := [LowerBound..UpperBound];
  CurrentNumber := LowerBound;
  WHILE CurrentNumber * CurrentNumber <= UpperBound
  DO
    BEGIN
      IF CurrentNumber IN Sieve
      THEN
        BEGIN
          Multiplier := CurrentNumber * CurrentNumber;
          WHILE Multiplier <= UpperBound - CurrentNumber
          DO
            BEGIN
              Sieve := Sieve - [Multiplier];
              Multiplier := Multiplier + CurrentNumber
            END;
          Sieve := Sieve - [Multiplier]
        END;
      CurrentNumber := CurrentNumber + 1
    END;
    
  WRITELN('������� ����� � ��������� �� ', LowerBound, ' �� ', UpperBound, ':');
  CurrentNumber := LowerBound;
  WHILE CurrentNumber <= UpperBound
  DO
    BEGIN
      IF CurrentNumber IN Sieve
      THEN
        WRITE(CurrentNumber, ' ');
      CurrentNumber := CurrentNumber + 1
    END;
  WRITELN
END.
