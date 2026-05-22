.PHONY: lint test install uninstall

lint:
	brew style Formula/platform-helper.rb

test:
	brew test demo/platform-tools/platform-helper

install:
	brew tap demo/platform-tools "https://github.com/attacker-demo/homebrew-platform-tools.git"
	brew install demo/platform-tools/platform-helper

uninstall:
	bash scripts/uninstall.sh
