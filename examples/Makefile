SRC=$(wildcard *.ml)
LIBDIR=../src
EXECS=$(SRC:.ml=.byte)
TARGETS=$(SRC:.ml=.js)
RICKSHAW=rickshaw.cma
LIB=-package js_of_ocaml $(RICKSHAW)
OCAMLFLAGS=-package js_of_ocaml.syntax -syntax camlp4o -I $(LIBDIR)
OCAMLLFLAGS=
all: $(TARGETS)

%.byte: %.ml $(LIBDIR)/$(RICKSHAW)
	@echo "[CC]" $@
	ocamlfind ocamlc -linkpkg -o $@ $(OCAMLFLAGS) $(LIB) $<

%.js: %.byte
	js_of_ocaml $^ -pretty

ocamldep:
	ocamlfind ocamldep -I $(LIBDIR) $(OCAMLFLAGS) $(SRC) 

clean:
	@echo "[CLEAN]"
	-rm -f *.cmo *.cmi $(TARGETS) $(EXECS)

var: 
	@echo $(TARGETS)
	@echo $(EXECS)
