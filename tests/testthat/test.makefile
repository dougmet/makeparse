TEST_FILES=$(wildcard test*.R)

## count_test_lines.txt : Run the pipeline
count_test_lines.txt : $(TEST_FILES)
	cat $(TEST_FILES) | awk '{n++}; END{print n}' > $@
