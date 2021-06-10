CC=gpc
CFLAGS=-Wall -Wextra -O3 --unit-destination-path=obj --gpi-destination-path=obj


all: WordReader.o WordTree.o FileDistributor.o r2.o build_dir
	$(CC) $(CFLAGS) -o build/r2 obj/WordReader.o obj/WordTree.o obj/FileDistributor.o obj/r2.o

WordReader.o: src/WordReader.pas obj_dir
	$(CC) $(CFLAGS) -c -o obj/WordReader.o src/WordReader.pas

WordTree.o: src/WordTree.pas obj_dir
	$(CC) $(CFLAGS) -c -o obj/WordTree.o src/WordTree.pas

FileDistributor.o: src/FileDistributor.pas obj_dir
	$(CC) $(CFLAGS) -c -o obj/FileDistributor.o src/FileDistributor.pas

r2.o: src/r2.pas obj_dir
	$(CC) $(CFLAGS) -c -o obj/r2.o src/r2.pas


obj_dir:
	mkdir -p obj

build_dir:
	mkdir -p build

clear:
	rm -r obj build
