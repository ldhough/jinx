CHARMC = $(CHARMDIR)/bin/charmc $(OPTS)

CXXFLAGS = -I tmp

default: all
all: jinx

.PHONY: clean
clean:
	rm -f obj/*.o tmp/main.decl.h tmp/main.def.h bin/jinx charmrun

jinx: obj/main.o
	$(CHARMC) $(CXXFLAGS) -language charm++ -o bin/jinx obj/main.o
	mv charmrun bin/

obj/main.o: src/main.C src/main.h tmp/main.decl.h tmp/main.def.h
	$(CHARMC) $(CXXFLAGS) -c -o obj/main.o src/main.C

tmp/main.decl.h tmp/main.def.h: src/main.ci
	$(CHARMC) src/main.ci
	mv main.decl.h main.def.h tmp/

