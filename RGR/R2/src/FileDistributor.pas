UNIT FileDistributor;
INTERFACE
USES
  WordReader, WordTree;

PROCEDURE InsertWordWithMemoryCheck(VAR Root: Tree; VAR Word: WordType); {вставка слова в дерево с проверкой переполнени€ дерева}
PROCEDURE FlushTree(VAR Root: Tree); {сохранение дерева в файл и очистка пам€ти дерева}
PROCEDURE PrintTreeFile(VAR FOut: TEXT); {вывод результата в текстовом формате}


IMPLEMENTATION
CONST
  MaxNodes = 1000;
  PrintSeparator = ' ';

TYPE
  TreeFile = FILE OF Node;

VAR
  NodeCount: INTEGER;
  IsFirstTree: BOOLEAN;
  TempFile1, TempFile2: TreeFile;

PROCEDURE CopyTreeToFile(VAR Root: Tree; VAR FOut: TreeFile);
{CopyTreeToFile: копирование дерева в файл узлов в
 отсортированном пор€дке}
BEGIN {CopyTreeToFile}
  IF Root <> NIL
  THEN
    BEGIN
      CopyTreeToFile(Root^.Left, FOut);
      WRITE(FOut, Root^);
      CopyTreeToFile(Root^.Right, FOut)
    END
END; {CopyTreeToFile}

PROCEDURE MergeRoutine(VAR Ptr: Tree; VAR FileNode: Node; VAR EOFBeforeTreeEnd: BOOLEAN);
{MergeRoutine: выполн€ет один проход сли€ни€, т.е. вставл€ет
 один узел}
VAR
  PtrPositionFound, PtrNodeInserted: BOOLEAN;
BEGIN {MergeRoutine}
  IF Ptr <> NIL
  THEN
    BEGIN
      MergeRoutine(Ptr^.Left, FileNode, EOFBeforeTreeEnd);
      PtrPositionFound := FALSE;
      PtrNodeInserted := FALSE;
      IF (FileNode.Word < Ptr^.Word) AND (NOT EOFBeforeTreeEnd)
      THEN
        BEGIN
          WRITE(TempFile2, FileNode);
          EOFBeforeTreeEnd := EOF(TempFile1)
        END
      ELSE
        IF FileNode.Word = Ptr^.Word
        THEN
          BEGIN
            FileNode.Amount := FileNode.Amount + Ptr^.Amount;
            WRITE(TempFile2, FileNode);
            PtrNodeInserted := TRUE
          END
        ELSE
          PtrPositionFound := TRUE;
      WHILE (NOT PtrPositionFound) AND (NOT EOF(TempFile1))
      DO
        BEGIN
          READ(TempFile1, FileNode);
          IF FileNode.Word < Ptr^.Word
          THEN
            BEGIN
              WRITE(TempFile2, FileNode);
              EOFBeforeTreeEnd := EOF(TempFile1)
            END
          ELSE
            IF FileNode.Word = Ptr^.Word
            THEN
              BEGIN
                FileNode.Amount := FileNode.Amount + Ptr^.Amount;
                WRITE(TempFile2, FileNode);
                PtrNodeInserted := TRUE
              END
            ELSE
              PtrPositionFound := TRUE
        END;
      IF NOT PtrNodeInserted
      THEN
        WRITE(TempFile2, Ptr^);
      MergeRoutine(Ptr^.Right, FileNode, EOFBeforeTreeEnd)
    END
END; {MergeRoutine}

PROCEDURE MergeTreeToFile(VAR Root: Tree);
{MergeTreeToFile: сли€ние дерева в файл}
VAR
  FileNode: Node;
  EOFBeforeTreeEnd: BOOLEAN;
BEGIN {MergeTreeToFile}
  RESET(TempFile1);
  REWRITE(TempFile2);
  READ(TempFile1, FileNode);
  EOFBeforeTreeEnd := FALSE;
  MergeRoutine(Root, FileNode, EOFBeforeTreeEnd);
  { опирование оставшихс€ в файле записей}
  IF NOT EOFBeforeTreeEnd
  THEN
    WRITE(TempFile2, FileNode);
  WHILE NOT EOF(TempFile1)
  DO
    BEGIN
      READ(TempFile1, FileNode);
      WRITE(TempFile2, FileNode)
    END;
  RESET(TempFile2);
  REWRITE(TempFile1);
  WHILE NOT EOF(TempFile2)
  DO
    BEGIN
      READ(TempFile2, FileNode);
      WRITE(TempFile1, FileNode)
    END
END; {MergeTreeToFile}

PROCEDURE FlushTree(VAR Root: Tree);
{FlushTree: сли€ние дерева в файл и освобождение пам€ти}
BEGIN {FlushTree}
  IF NodeCount <> 0
  THEN
    IF IsFirstTree
    THEN
      BEGIN
        REWRITE(TempFile1);
        CopyTreeToFile(Root, TempFile1);
        IsFirstTree := FALSE
      END
    ELSE
      MergeTreeToFile(Root);
  DisposeTree(Root)
END; {FlushTree}

PROCEDURE InsertWordWithMemoryCheck(VAR Root: Tree; VAR Word: WordType);
{InsertWordWithMemoryCheck: обертка над InsertWord, выполн€ет проверку
 количества узлов перед вставкой}
BEGIN {InsertWordWithMemoryCheck}
  IF InsertWord(Root, Word)
  THEN
    NodeCount := NodeCount + 1;
  IF NodeCount > MaxNodes
  THEN
    BEGIN
      FlushTree(Root);
      NodeCount := 0
    END
END; {InsertWordWithMemoryCheck}

PROCEDURE PrintTreeFile(VAR FOut: TEXT);
{PrintTreeFile: вывод файла узлов в текстовый файл}
VAR
  CurrentNode: Node;
BEGIN {PrintTreeFile}
  RESET(TempFile1);
  WHILE NOT EOF(TempFile1)
  DO
    BEGIN
      READ(TempFile1, CurrentNode);
      WRITELN(FOut, CurrentNode.Word, PrintSeparator, CurrentNode.Amount)
    END
END; {PrintTreeFile}

BEGIN {FileDistributor}
  IsFirstTree := TRUE;
  NodeCount := 0
END. {FileDistributor}
