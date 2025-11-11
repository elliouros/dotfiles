# test definition for isolating, comment/delete when actually using
# XDG_CONFIG_HOME = $(HOME)/iso

STOW = stow -v
CONFDIR = $(or $(XDG_CONFIG_HOME),$(HOME)/.config)

# Packages whose contents go to the above defined CONFDIR.
CONFIGPKGS = foot helix nushell qutebrowser sway swaylock tofi vesktop
# Packages whose contents go to HOME.
HOMEPKGS = 

.PHONY: $(CONFIGPKGS) $(HOMEPKGS) unstow clean all standard extimus angelos

$(CONFIGPKGS):
	$(STOW) -Rt $(CONFDIR) $@

$(HOMEPKGS):
	$(STOW) -Rt $(HOME) $@

unstow:
	for pkg in $(CONFIGPKGS); do \
		$(STOW) -t "$(CONFDIR)" -D "$$pkg"; \
	done
	for pkg in $(HOMEPKGS); do \
		$(STOW) -t "$(HOME)" -D "$$pkg"; \
	done

clean: unstow


# configs for every environment that uses my preferred programs
standard: helix nushell
all: standard

# questionable to use this, given that the point of this makefile is modularity
# between environments.
true-all: $(CONFIGPKGS) $(HOMEPKGS)

# lightweight sway environment, very keyboard centric
# (lightweight is questionable for qutebrowser -w-)
# one may also want to include vesktop.
extimus: standard foot qutebrowser sway swaylock tofi

# currently, a Mint Cinnamon environment
angelos: standard vesktop
