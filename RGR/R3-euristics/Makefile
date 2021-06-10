CC=gpc
CFLAGS=-Wall -Wextra -O3 --unit-destination-path=obj --gpi-destination-path=obj


all: WordReader.o Morphology.o Container.o r3.o build_dir
	$(CC) $(CFLAGS) -o build/r3 obj/WordReader.o obj/Morphology.o obj/Container.o obj/r3.o

WordReader.o: src/WordReader.pas obj_dir
	$(CC) $(CFLAGS) -c -o obj/WordReader.o src/WordReader.pas

Morphology.o: src/Morphology.pas obj_dir
	$(CC) $(CFLAGS) -c -o obj/Morphology.o src/Morphology.pas

Container.o: src/Container.pas obj_dir
	$(CC) $(CFLAGS) -c -o obj/Container.o src/Container.pas

r3.o: src/r3.pas obj_dir
	$(CC) $(CFLAGS) -c -o obj/r3.o src/r3.pas


obj_dir:
	mkdir -p obj

build_dir:
	mkdir -p build

clear:
	rm -r obj build
