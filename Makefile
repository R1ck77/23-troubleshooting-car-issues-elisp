.PHONY: test

test:
	emacs -batch -f package-initialize -f buttercup-run-discover
