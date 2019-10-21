RST_MAINFILE = assignment_all.rst


# Please don't touch the following settings
DIR_NAME := $(shell basename "$(CURDIR)")
ASSIGNMENT_PDF := "assignment $(DIR_NAME).pdf"


.PHONY: help
help: ## Display this help message
	@echo "Usage: make \033[36m[TARGET]\033[0m...\n\nTargets:"
	@awk -F ':|##' '/^[^\t].+?:.*?##/ { \
		printf "  \033[36m%-16s\033[0m %s\n", $$1, $$NF \
	}' $(MAKEFILE_LIST)


.PHONY: assignment-clean
assignment-clean: ## Remove all generated student assignment files
	rm -f $(ASSIGNMENT_PDF)

.PHONY: assignment-build
assignment-build: ## Build the student assignment PDF
	rst2pdf $(RST_MAINFILE) -o $(ASSIGNMENT_PDF) -s a4,freetype-serif

.PHONY: assignment-view
assignment-view: assignment-build ## View the student assignment PDF (runs 'build' if needed)
	xdg-open $(ASSIGNMENT_PDF)
