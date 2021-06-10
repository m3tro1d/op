UNIT WordTree;
{WordTree: модуль для хранения и вывода статистики слов}
INTERFACE
USES WordReader;

TYPE
  Tree = ^Node;
  Node = RECORD
      Word: WordType;
      Amount: INTEGER;
      Left, Right: Tree
    END;

PROCEDURE InsertWord(VAR Root: Tree; VAR Word: WordType); {Вставить слово в дерево}
PROCEDURE PrintWordTree(VAR FOut: TEXT; VAR Root: Tree); {Распечатать дерево в файл}
PROCEDURE DisposeTree(VAR Root: Tree); {Очистка дерева}


IMPLEMENTATION
CONST
  PrintSeparator = ' ';

PROCEDURE DistributeWordNode(VAR Ptr: Tree; VAR Word: WordType);
{DistributeWordNode: сортировка слова по ветвям узла}
BEGIN {DistributeWordNode}
  IF Word < Ptr^.Word
  THEN
    InsertWord(Ptr^.Left, Word)
  ELSE
    IF Ptr^.Word < Word
    THEN
      InsertWord(Ptr^.Right, Word)
    ELSE {Если слово то же самое, увеличиваем число вхождений}
      Ptr^.Amount := Ptr^.Amount + 1
END; {DistributeWordNode}

PROCEDURE AddWordNode(VAR Ptr: Tree; VAR Word: WordType);
{AddWordNode: создание нового узла в Ptr}
BEGIN {AddWordNode}
  NEW(Ptr);
  Ptr^.Left := NIL;
  Ptr^.Right := NIL;
  Ptr^.Word := Word;
  Ptr^.Amount := 1
END; {AddWordNode}

PROCEDURE InsertWord(VAR Root: Tree; VAR Word: WordType);
{InsertWord: создание узла, если его нет, иначе вставка в
 соответствующую ветвь}
BEGIN {InsertWord}
  IF Root = NIL
  THEN
    AddWordNode(Root, Word)
  ELSE
    DistributeWordNode(Root, Word)
END; {InsertWord}

PROCEDURE PrintWordTree(VAR FOut: TEXT; VAR Root: Tree);
{PrintWordTree: вывод левого узла, текущего узла и правого узла}
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
{DisposeTree: рекурсивное освобождение указателей на узлы дерева}
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
