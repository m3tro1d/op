PROGRAM PaulRevere(INPUT, OUTPUT);
{����� ᮮ⢥�����饣� ᮮ�饭��, ������饣� �� ����稭�
 �� �室�:  '...by land'  ��� 1;  '...by sea'  ��� 2;
 ���� ����� ᮮ�饭�� �� �訡��}
VAR
  Lanterns: CHAR;
BEGIN {PaulRevere}
  {Read Lanterns}
  READ(Lanterns);
  {Check the Lanterns}
  IF Lanterns >= '1'
  THEN
    IF Lanterns <= '2'
    THEN
      WRITE('The British are coming by ');
  {Issue Paul Revere's message}
  IF Lanterns = '1'
  THEN
    WRITELN('land.')
  ELSE
    IF Lanterns = '2'
    THEN
      WRITELN('sea.')
    ELSE
      WRITELN('The North Church shows only ''', Lanterns, '''.')
END. {PaulRevere}
