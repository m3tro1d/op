PROGRAM TreeSort(INPUT, OUTPUT);
TYPE 
  Tree = ^NodeType;
  NodeType = RECORD
               Ch: CHAR;
               LLink, RLink: Tree
             END;
VAR
  Root: Tree;
  Ch: CHAR;

PROCEDURE PrintTree(VAR Ptr: Tree);
BEGIN {PrintTree}
  IF Ptr <> NIL
  THEN  {Печатает поддерево слева, вершину, поддерево справа}
    BEGIN
      PrintTree(Ptr^.LLink);
      WRITE(Ptr^.Ch);
      PrintTree(Ptr^.RLink)
    END
END;  {PrintTree}

BEGIN {TreeSort}
  Root := NIL;
  {WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      Insert(Root, Ch)
    END;}
  NEW(Root);
  Root^.Ch := 'A';
  
  NEW(Root^.LLink);
  Root^.LLink^.Ch := 'B';
  
  NEW(Root^.LLink^.LLink);
  Root^.LLink^.LLink^.Ch := 'C';
            
  NEW(Root^.LLink^.RLink);
  Root^.LLink^.RLink^.Ch := 'D';
  
  NEW(Root^.RLink);
  Root^.RLink^.Ch := 'E';
  
  PrintTree(Root);
  WRITELN
END. {TreeSort}
