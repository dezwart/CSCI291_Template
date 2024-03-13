.PHONY: clean 

DEPEND=$(shell "if [ ! -e .depend ]; then touch .depend; fi")
CFLAGS += -std=c17 -Wall -pedantic
LFLAGS +=
LIBS =
CC = gcc

SOURCES = main.c
TARGETS = $(SOURCES:.c=.o)
EXECUTABLES = main

all: $(EXECUTABLES)

%.d: %.c
	set -e; $(CC) -M $(CPPFLAGS) $< \
		| sed 's/\($*\)\.o[ :]*/\1.o $@ : /g' > $@; \
		[ -s $@ ] || rm -f $@
	
clean:
	rm -f *.[od] core tags $(EXECUTABLES)

# Include the dependencies
include $(SOURCES:.c=.d)

main: $(TARGETS)
	$(CC) $(CFLAGS) $(LFLAGS) -o $@ $(TARGETS) $(LIBS)

.c.o:
	$(CC) -c $(CFLAGS) $<
