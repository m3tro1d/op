CC=gpc
CFLAGS=-Wall -Wextra -O3 --unit-destination-path=obj --gpi-destination-path=obj


all: WordReader.o Stemmer.o Container.o Statistics.o r3.o build_dir
	$(CC) $(CFLAGS) -o build/r3 obj/WordReader.o obj/Stemmer.o obj/Container.o obj/Statistics.o obj/r3.o

test: WordReader.o Stemmer.o r3-stemmer.o build_dir
	$(CC) $(CFLAGS) -o build/r3-stemmer obj/WordReader.o obj/Stemmer.o obj/r3-stemmer.o

WordReader.o: src/WordReader.pas obj_dir
	$(CC) $(CFLAGS) -c -o obj/WordReader.o src/WordReader.pas

Stemmer.o: src/Stemmer.pas obj_dir
	$(CC) $(CFLAGS) -c -o obj/Stemmer.o src/Stemmer.pas

Container.o: src/Container.pas obj_dir
	$(CC) $(CFLAGS) -c -o obj/Container.o src/Container.pas

Statistics.o: src/Statistics.pas obj_dir
	$(CC) $(CFLAGS) -c -o obj/Statistics.o src/Statistics.pas

r3.o: src/r3.pas obj_dir
	$(CC) $(CFLAGS) -c -o obj/r3.o src/r3.pas

r3-stemmer.o: src/r3-stemmer.pas obj_dir
	$(CC) $(CFLAGS) -c -o obj/r3-stemmer.o src/r3-stemmer.pas


obj_dir:
	mkdir -p obj

build_dir:
	mkdir -p build

clear:
	rm -r obj build
