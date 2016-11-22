include config.mk

TXT_FILES=$(wildcard books/*.txt)
DAT_FILES=$(patsubst books/%.txt, %.dat, $(TXT_FILES))

## results.txt : Run the pipeline
results.txt : $(DAT_FILES) $(ZIPF_SRC)
	$(ZIPF_EXE) $(DAT_FILES) > $@

# Count words.

%.dat : books/%.txt $(COUNT_SRC)
	$(COUNT_EXE) $< $*.dat

## clean       : Remove auto-generated files.
.PHONY : clean
clean :
	rm -f *.dat
	rm -f results.txt

.PHONY : variables
variables:
	@echo TXT_FILES: $(TXT_FILES)

## dats        : Build the dat files
.PHONY : dats
dats: $(DAT_FILES)

.PHONY : help
help : Makefile
	@sed -n 's/^##//p' $<
