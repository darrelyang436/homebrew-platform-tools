.PHONY: lint test audit install uninstall

lint:
	brew style Formula/platform-helper.rb

audit:
	brew audit --strict --online Formula/platform-helper.rb

test:
	brew test darrelyang436/platform-tools/platform-helper

install:
	brew tap darrelyang436/platform-tools
	brew install darrelyang436/platform-tools/platform-helper

uninstall:
	bash scripts/uninstall.sh
