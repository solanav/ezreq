#!/bin/bash
export OCAMLRUNPARAM=p
make && ./ezreq examples/test2.ezr && echo && python3 examples/test2.py