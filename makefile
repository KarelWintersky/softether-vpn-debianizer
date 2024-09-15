#!/usr/bin/make
COPYRIGHT = "Karel Wintersky <karel.wintersky@yandex.ru"
INSTALL_PATH = $(DESTDIR)/usr/local/softether/vpnclient

default:
	@echo
	@echo "======================= HOW TO BUILD ?? ======================="
	@echo
	@echo "Download TAR.GZ archive with prebuild code from https://www.softether-download.com/en.aspx"
	@echo "Unpack it here: tar -xzf file.gz"
	@echo
	@echo "Be sure that the software required for assembly is installed."
	@echo "... for this you can run:"
	@echo
	@echo "$(YELLOW)make prepare$(RESET)"
	@echo
	@echo "If you need update version of target package, run:"
	@echo
	@echo "$(YELLOW)make dchv$(RESET)"
	@echo
	@echo "Set new version, update chagelog:"
	@echo
	@echo "$(YELLOW)make dchr$(RESET)"
	@echo
	@echo "Set version from unreleased to (un)stable."
	@echo
	@echo "Then, run:"
	@echo
	@echo "$(YELLOW)make build$(RESET)"
	@echo
	@echo "Package will be placed at $(YELLOW)../$(RESET) directory"
	@echo
	@echo "$(GREEN)Done! you are great!$(RESET)"
	@echo
	@echo "============================ DONE ============================="

help:
	@perl -e '$(HELP_ACTION)' $(MAKEFILE_LIST)

prepare:		##@build Install required dependencies for build process
	@apt-get -y install debhelper dh-make devscripts fakeroot build-essential automake gnupg

dchr:		##@development Publish release
	@dch --controlmaint --release --distribution unstable

dchv:		##@development Append release
	@export DEBEMAIL="karel.wintersky@yandex.ru" && \
	export DEBFULLNAME="Wombat" && \
	echo "$(YELLOW)------------------ Previous version header: ------------------$(GREEN)" && \
	head -n 3 debian/changelog && \
	echo "$(YELLOW)--------------------------------------------------------------$(RESET)" && \
	read -p "Next version: " VERSION && \
	dch --controlmaint -v $$VERSION

build:			##@build Build project to DEB Package
	@echo Building project to DEB-package
	@dh_clean
	make -C vpnclient
	DEB_BUILD_OPTIONS=terse dpkg-buildpackage -rfakeroot --no-sign --build=binary
	@dh_clean

install:	##@system Install package. Don't run it manually!!!
	install -d $(INSTALL_PATH)
	cp vpnclient/vpnclient $(INSTALL_PATH)/
	cp vpnclient/vpncmd $(INSTALL_PATH)/
	cp vpnclient/hamcore.se2 $(INSTALL_PATH)/
	cp vpnclient/ReadMeFirst_Important_Notices_en.txt  $(INSTALL_PATH)/
	cp assets/softether-vpnclient.service $(INSTALL_PATH)/
	cp assets/vpnclient.sh $(INSTALL_PATH)/

# ------------------------------------------------
# Add the following 'help' target to your makefile, add help text after each target name starting with '\#\#'
# A category can be added with @category
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)
HELP_ACTION = \
	%help; while(<>) { push @{$$help{$$2 // 'options'}}, [$$1, $$3] if /^([a-zA-Z\-_]+)\s*:.*\#\#(?:@([a-zA-Z\-]+))?\s(.*)$$/ }; \
	print "usage: make [target]\n\n"; for (sort keys %help) { print "${WHITE}$$_:${RESET}\n"; \
	for (@{$$help{$$_}}) { $$sep = " " x (32 - length $$_->[0]); print "  ${YELLOW}$$_->[0]${RESET}$$sep${GREEN}$$_->[1]${RESET}\n"; }; \
	print "\n"; }

# -eof-
