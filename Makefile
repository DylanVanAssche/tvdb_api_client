TEST_FLAGS = --cov=src
TEST_PATH = tests

.PHONY: install
install: requirements.txt
	poetry install $(POETRY_EXTRA)

poetry.lock: pyproject.toml
	poetry lock

requirements.txt: poetry.lock
	poetry install $(POETRY_EXTRA)
	poetry show --no-dev | awk '{print $$1"=="$$2}' > $@

.PHONY: format
format:
	isort --recursive .
	black .

.PHONY: lint
lint:
	flake8 .
	isort --check-only --recursive .
	black --check .

.PHONY: tests
tests:
	py.test $(TEST_FLAGS) $(TEST_PATH)