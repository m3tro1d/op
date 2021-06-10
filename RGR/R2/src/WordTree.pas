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

FUNCTION InsertWord(VAR Root: Tree; VAR Word: WordType): BOOLEAN; {�������� ����� � ������; ���������� TRUE, ���� ��� ������ *�����* ����}
PROCEDURE DisposeTree(VAR Root: Tree); {������� ������}


IMPLEMENTATION
FUNCTION DistributeWordNode(VAR Ptr: Tree; VAR Word: WordType): BOOLEAN;
{DistributeWordNode: ���������� ����� �� ������ ����}
BEGIN {DistributeWordNode}
  DistributeWordNode := FALSE;
  IF Word < Ptr^.Word
  THEN
    DistributeWordNode := InsertWord(Ptr^.Left, Word)
  ELSE
    IF Ptr^.Word < Word
    THEN
      DistributeWordNode := InsertWord(Ptr^.Right, Word)
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

FUNCTION InsertWord(VAR Root: Tree; VAR Word: WordType): BOOLEAN;
{InsertWord: �������� ����, ���� ��� ���, ����� ������� �
 ��������������� �����}
BEGIN {InsertWord}
  InsertWord := FALSE;
  IF Root = NIL
  THEN
    BEGIN
      AddWordNode(Root, Word);
      InsertWord := TRUE
    END
  ELSE
    InsertWord := DistributeWordNode(Root, Word)
END; {InsertWord}

PROCEDURE DisposeTree(VAR Root: Tree);
{DisposeTree: ����������� ������������ ���������� �� ���� ������}
BEGIN {DisposeTree}
  IF Root <> NIL
  THEN
    BEGIN
      DisposeTree(Root^.Left);
      DisposeTree(Root^.Right);
      DISPOSE(Root);
      Root := NIL
    END
END; {DisposeTree}

BEGIN {WordTree}
END. {WordTree}
