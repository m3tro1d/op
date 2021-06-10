UNIT WordTree;
{WordTree: ������ ��� �������� � ������ ���������� ����}
INTERFACE
USES WordReader;

TYPE
  Tree = ^Node;
  Node = RECORD
      Word: WordType;
      Amount: INTEGER;
      Left, Right: Tree
    END;

PROCEDURE InsertWord(VAR Root: Tree; VAR Word: WordType); {�������� ����� � ������}
PROCEDURE PrintWordTree(VAR FOut: TEXT; VAR Root: Tree); {����������� ������ � ����}
PROCEDURE DisposeTree(VAR Root: Tree); {������� ������}


IMPLEMENTATION
CONST
  PrintSeparator = ' ';

PROCEDURE DistributeWordNode(VAR Ptr: Tree; VAR Word: WordType);
{DistributeWordNode: ���������� ����� �� ������ ����}
BEGIN {DistributeWordNode}
  IF Word < Ptr^.Word
  THEN
    InsertWord(Ptr^.Left, Word)
  ELSE
    IF Ptr^.Word < Word
    THEN
      InsertWord(Ptr^.Right, Word)
    ELSE {���� ����� �� �� �����, ����������� ����� ���������}
      Ptr^.Amount := Ptr^.Amount + 1
END; {DistributeWordNode}

PROCEDURE AddWordNode(VAR Ptr: Tree; VAR Word: WordType);
{AddWordNode: �������� ������ ���� � Ptr}
BEGIN {AddWordNode}
  NEW(Ptr);
  Ptr^.Left := NIL;
  Ptr^.Right := NIL;
  Ptr^.Word := Word;
  Ptr^.Amount := 1
END; {AddWordNode}

PROCEDURE InsertWord(VAR Root: Tree; VAR Word: WordType);
{InsertWord: �������� ����, ���� ��� ���, ����� ������� �
 ��������������� �����}
BEGIN {InsertWord}
  IF Root = NIL
  THEN
    AddWordNode(Root, Word)
  ELSE
    DistributeWordNode(Root, Word)
END; {InsertWord}

PROCEDURE PrintWordTree(VAR FOut: TEXT; VAR Root: Tree);
{PrintWordTree: ����� ������ ����, �������� ���� � ������� ����}
BEGIN {PrintWordTree}
  IF Root <> NIL
  THEN
    BEGIN
      PrintWordTree(FOut, Root^.Left);
      WRITELN(FOut, Root^.Word, PrintSeparator, Root^.Amount);
      PrintWordTree(FOut, Root^.Right)
    END
END; {PrintWordTree}

PROCEDURE DisposeTree(VAR Root: Tree);
{DisposeTree: ����������� ������������ ���������� �� ���� ������}
BEGIN {DisposeTree}
  IF Root <> NIL
  THEN
    BEGIN
      DisposeTree(Root^.Left);
      DisposeTree(Root^.Right);
      DISPOSE(Root)
    END
END; {DisposeTree}

BEGIN {WordTree}
END. {WordTree}
