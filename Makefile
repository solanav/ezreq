main:
	ocamlc -c codegen.ml
	
	ocamllex lexer.mll       # generates lexer.ml
	ocamlyacc parser.mly     # generates parser.ml and parser.mli

	ocamlc -c parser.mli
	ocamlc -c lexer.ml
	ocamlc -c parser.ml
	
	ocamlc -c ezreq.ml
	ocamlc -o ezreq str.cma codegen.cmo lexer.cmo parser.cmo ezreq.cmo

clean:
	rm -f examples/*.py
	rm -f *.cmo
	rm -f *.cmi
	rm -f lexer.ml
	rm -f parser.ml
	rm -f parser.mli
	rm -f ezreq