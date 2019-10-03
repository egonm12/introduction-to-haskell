
build:
	stack build

configure:
	hpack .

test:
	stack test

repl:
	stack repl

continuous_test:
	stack test --fast --file-watch

.PHONY: build configure test continuous_test repl

