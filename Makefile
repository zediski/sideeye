.PHONY: clean build lint test help

clean:
	@find . -name '*.pyc' -exec rm -f {} +
	@find . -name '*.pyo' -exec rm -f {} +
	@find . -name '*~' -exec rm -f  {} +
	@find . -name '__pycache__' -exec rm -rf {} +
	@rm -rf *.egg-info

lint:
	pylint sideeye --disable=too-few-public-methods,too-many-arguments,too-many-branches --output-format=colorized || true
	pylint tests --disable=too-few-public-methods,too-many-arguments,wildcard-import,too-many-branches,missing-docstring,duplicate-code --output-format=colorized || true

build: clean
	pip install -e .[test]

test:
	nose2 -c tests/nose2.cfg -v --layer-reporter
	@make clean

typecheck:
	mypy .

testall: build lint typecheck test

help:
	@echo "  clean"
	@echo "    Remove python artifacts."
	@echo "  lint"
	@echo "    Check style with pylint."
	@echo "  test"
	@echo "    Run nose2 tests."
	@echo "  build"
	@echo "    Clean artifacts and rebuild package."
	@echo "  typecheck"
	@echo "    Typecheck with mypy."
	@echo "  testall"
	@echo "    Build, lint, typecheck, and run tests"
