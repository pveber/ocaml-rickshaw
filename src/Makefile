JS_OF_OCAML?=$(shell ocamlfind query js_of_ocaml)
LIB=$(JS_OF_OCAML_PATH)/lib

OCAMLFLAGS=$(INCLUDES) -package js_of_ocaml.syntax -syntax camlp4o
OCAMLIFLAGS=$(INCLUDES) -package js_of_ocaml -pp "cpp -traditional-cpp"
RICKSHAW=rickshaw.cma
LIBRARY=rickshaw
MLS=$(shell find * -name "*.ml")
MLIS=$(shell find * -name "*.mli")
OCAMLFIND=ocamlfind
OCAMLDOC=ocamldoc
CMOS=rickshaw.cmo
CMIS=rickshaw.cmi

all: $(RICKSHAW)

-include .depend

$(RICKSHAW): $(CMOS)
	$(OCAMLFIND) ocamlc -a -o $@ $^

.SECONDEXPANSION:

%.cmo: %.ml %.cmi
	@echo "[CC] $@"
	$(OCAMLFIND) ocamlc $(OCAMLFLAGS) -c $<

%.cmi: %.mli
	$(OCAMLFIND) ocamlc $(OCAMLIFLAGS) -c $<

depend: ocamldep

ocamldep:
	($(OCAMLFIND) ocamldep $(OCAMLFLAGS) $(MLS); \
	$(OCAMLFIND) ocamldep $(OCAMLIFLAGS) $(MLIS)) > .depend

.PRECIOUS: $(CMIS)
