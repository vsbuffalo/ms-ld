CC=clang++
CFLAGS=-lsequence -lz -O0 -g -Wextra
NSIMS=12

sim: recomb.txt no-recomb.txt ld
	Rscript ld-decay.R recomb.txt no-recomb.txt

ld: ld.cpp
	$(CC) $(CFLAGS) -o ld $<

.PHONY: clean

clean: 
	rm -f ld recomb.txt no-recomb.txt

clean-sim:
	rm -f recomb.txt no-recomb.txt

recomb.txt: ld
	ms 11 $(NSIMS) -t 100 -r 100 1000 | ./ld > recomb.txt

no-recomb.txt: ld
	ms 11 $(NSIMS) -t 100 | ./ld > no-recomb.txt
