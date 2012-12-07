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

all:
	make -C src

examples: all
	@(${MAKE} -C examples);


distclean: clean
	-rm -f .depend

clean:
	@echo "[CLEAN]"
	-rm -f src/$(RICKSHAW)
	-find src -name "*.cm[oix]" -exec rm {} \;
	-find src -name "*.cm[t]" -exec rm {} \;
	-find src -name "*.cmt[i]" -exec rm {} \;
	${MAKE} -C examples clean

install:
	ocamlfind install jquery META oquery.cma $(CMIS) $(MLIS)

uninstall:
	ocamlfind remove jquery
