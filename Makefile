RST_MAINFILE = assignment_all.rst

ARCHIVES_DIR = archives
EXTRACT_DIR = extracted


# Please don't touch the following settings
DIR_NAME = $(shell basename "$(CURDIR)")
TEMPLATES_DIR = .templates
TEST_IDS = $(shell ls -m $(TEMPLATES_DIR))
ASSIGNMENT_PDF = "assignment $(DIR_NAME).pdf"
ASSIGNMENT_ARCHIVE = "assignment_packed_for_students $(DIR_NAME).tar.gz"
SMOKE_TEST_VERSION = $(shell pipenv lock -r | grep smoke-test | awk -F "==" '{ print $$NF }')
SMOKE_TEST_PEX_URL = https://github.com/petarmaric/smoke_test/releases/download/$(SMOKE_TEST_VERSION)/smoke_test-$(SMOKE_TEST_VERSION).pex

ifdef quiet
	VERBOSITY = --quiet
endif


.PHONY: help
help: ## Display this help message
	@echo "Usage: make \033[36m[TARGET]\033[0m \033[32m[quiet=1]\033[0m ...\n\nTargets:"
	@awk -F ':|##' '/^[^\t].+?:.*?##/ { \
		printf "  \033[36m%-16s\033[0m %s\n", $$1, $$NF \
	}' $(MAKEFILE_LIST)


.PHONY: init
init: ## Initialize the assignment template
ifndef template
	@echo "Usage: make init template=\033[36mTEST_ID\033[0m\n"
	@echo "Where \033[36mTEST_ID\033[0m can be: $(TEST_IDS)"
else
	cp -r $(TEMPLATES_DIR)/$(template)/. .
endif

.PHONY: init-revert
init-revert:
	rm -rf $(shell ls $(TEMPLATES_DIR)/T12)


.PHONY: test-solution
test-solution: ## Test your assignment solution
	smoke_test assignment_solution.c $(VERBOSITY)


.PHONY: assignment-clean
assignment-clean: ## Remove all generated student assignment files
	rm -f $(ASSIGNMENT_PDF) $(ASSIGNMENT_ARCHIVE)

.PHONY: assignment-build
assignment-build: ## Build the student assignment PDF
	rst2pdf $(RST_MAINFILE) -o $(ASSIGNMENT_PDF) -s a4,freetype-serif
	@echo "Finished building, the PDF has been saved to '$(ASSIGNMENT_PDF)'"

.PHONY: assignment-view
assignment-view: assignment-build ## View the student assignment PDF
	xdg-open $(ASSIGNMENT_PDF)

.PHONY: assignment-pack
assignment-pack: test-solution assignment-build ## Pack the student assignment
	tar -czf $(ASSIGNMENT_ARCHIVE) smoke_test.pex fixtures/ assignment.c $(ASSIGNMENT_PDF)
	@echo "Finished packing, the archive has been saved to '$(ASSIGNMENT_ARCHIVE)'"

.PHONY: assignment
assignment: assignment-clean assignment-pack assignment-view ## Build, view and pack the student assignment


.PHONY: extract-exams
extract-exams: ## Extract student assignments from exam archives
	acs_extract_student_assignments --archives-dir $(ARCHIVES_DIR) --extract-dir $(EXTRACT_DIR) $(VERBOSITY)

examine: ## Examine student assignment
ifndef computer
	@echo "Usage: make examine \033[32m[quiet=1]\033[0m computer=\033[36mCOMPUTER\033[0m\n"
	@echo "Where \033[36mCOMPUTER\033[0m is within the range of \033[36ms100\033[0m to \033[36ms131\033[0m," \
		  "or \033[36ms200\033[0m to \033[36ms231\033[0m"
else
	acs_examine_student_assignment $(computer) --extract-dir $(EXTRACT_DIR) $(VERBOSITY)
endif


update-dependencies:
	pipenv update
	wget $(SMOKE_TEST_PEX_URL) -O smoke_test.pex
	chmod +x smoke_test.pex
