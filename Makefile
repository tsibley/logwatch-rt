PREFIX := /etc/logwatch
BIN  := scripts/services/rt
CONF := conf/logfiles/rt.conf \
		conf/services/rt.conf
TEMPLATE := conf/rt-ignore.conf
FILES := $(BIN) $(CONF) $(TEMPLATE)

install: install-dirs
	@for file in $(BIN); do \
		install -pv $$file $(PREFIX)/$$file; \
	done
	@for file in $(CONF); do \
		install -pv --mode=0644 $$file $(PREFIX)/$$file; \
	done
	@for file in $(TEMPLATE); do \
		if [ -f $(PREFIX)/$$file ]; then \
			echo Not overwriting existing $(PREFIX)/$$file - installing with .dist suffix; \
			suffix=".dist"; \
		else \
			suffix=""; \
		fi; \
		install -pv --mode=0644 $$file $(PREFIX)/$$file$$suffix; \
	done

install-dirs:
	@for file in $(FILES); do \
		install -v -d `dirname $(PREFIX)/$$file`; \
	done
