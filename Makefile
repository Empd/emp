# 
# Extensible Monitoring Platform Makefile
#


ERL=$(shell which erl)
ERLFLAGS= -pa ./ebin -pa ./deps/*/ebin -pa ./plugins/ebin
EMPFLAG= "-eval 'emp:start().'"
DEPSOLVER_PLT=$(CURDIR)/.depsolver_plt
REBAR=$(CURDIR)/bin/rebar
RELDIR=$(CURDIR)/rel


.PHONY: emp compile deps docs eunit diailyzer typer clean distclean


##BUILDING
emp: deps startemp.sh loaderl.sh
	$(REBAR) compile

startemp.sh:
	touch startemp.sh
	echo "#!/bin/sh" > startemp.sh
	echo $(ERL) $(ERLFLAGS) $(EMPFLAG) >> startemp.sh
	chmod +x startemp.sh

loaderl.sh:
	touch loaderl.sh
	echo "#!/bin/sh" > loaderl.sh
	echo $(ERL) $(ERLFLAGS) >> loaderl.sh
	chmod +x loaderl.sh

compile: emp
	mkdir $(RELDIR)
	cd $(RELDIR)
	$(REBAR) create-node nodeid=emp
	cp $(RELTOOL_CFG) $(RELDIR)
	$(REBAR) generate

deps:
	$(REBAR) get-deps

docs: 
	$(REBAR) doc

##TESTING 
eunit:
	$(REBAR) eunit

$(DEPSOLVER_PLT):
	dialyzer --output_plt $(DEPSOLVER_PLT) --build_plt \
	         --apps erts kernel stdlib crypto public_key sasl -r deps

dialyzer: $(DEPSOLVER_PLT)
	dialyzer --plt $(DEPSOLVER_PLT) -Wrace_conditions --src lib

typer: $(DEPSOLVER_PLT)
	typer --plt $(DEPSOLVER_PLT) -r ./lib

##CLEANING
clean:
	$(REBAR) clean
	-rm startemp.sh

distclean: clean
	$(REBAR) delete-deps
	-rm $(DEPSOLVER_PLT)


