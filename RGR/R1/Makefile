CC=gpc
CFLAGS=-Wall -Wextra -O3 --unit-destination-path=obj --gpi-destination-path=obj


all: WordReader.o WordTree.o r1.o build_dir
	$(CC) $(CFLAGS) -o build/r1 obj/WordReader.o obj/WordTree.o obj/r1.o

WordReader.o: src/WordReader.pas obj_dir
	$(CC) $(CFLAGS) -c -o obj/WordReader.o src/WordReader.pas

WordTree.o: src/WordTree.pas obj_dir
	$(CC) $(CFLAGS) -c -o obj/WordTree.o src/WordTree.pas

r1.o: src/r1.pas obj_dir
	$(CC) $(CFLAGS) -c -o obj/r1.o src/r1.pas


obj_dir:
	mkdir -p obj

build_dir:
	mkdir -p build

clear:
	rm -r obj build
