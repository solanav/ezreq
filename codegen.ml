(* code generation *)
let chan = ref stdout
let set_chan new_chan = chan := new_chan
let gen v = output_string !chan v; output_string !chan "\n"
let gen_nonl v = output_string !chan v

let generate_begin () = gen
"#!/usr/bin/env python
# -*- coding: utf-8 -*-

\"\"\" File automatically generated by Sopy \"\"\"
def print_sopy(var):
    try:
        print(var.text)
    except AttributeError:
        print(var)

import requests
"

let generate_end () = gen
"
exit(0)"

let generate_comment t = gen_nonl ("# " ^ t)

let generate_assign t = gen_nonl (t ^ " = ")

let generate_get var url = gen (var ^ " = requests.get(" ^ url ^ ")")

let generate_print var = gen ("print_sopy(" ^ var ^ ")")

let generate_extract var origin s e = gen (var ^ " = " ^ origin ^ ".text.split(" ^ s ^ ")[1].split(" ^ e ^ ")[0]")