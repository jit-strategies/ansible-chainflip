all: clean contributor_init update
setup: clean contributor_init

update:
	@echo "Updating dependencies..."
	. .venv/bin/activate
	.venv/bin/pip3 install -r requirements.txt
	.venv/bin/ansible-galaxy install -r requirements.yml

contributor_init:
	@echo "Setting up advanced environment..."
	python3 -m venv .venv
	. .venv/bin/activate
	.venv/bin/python3 -m pip install --upgrade pip
	.venv/bin/pip3 install -r requirements.txt
	.venv/bin/ansible-galaxy install -r requirements.yml
	@echo "Setting up git hooks..."
	cp .git-hooks/pre-commit .git/hooks/
	chmod +x .git/hooks/pre-commit

clean:
	@echo "Cleaning up virtual environment ..."
	rm -rf .venv
