{

open Parser

(* current token line number *)
let line_num = ref 1

exception Syntax_error of string

let syntax_error msg = raise (Syntax_error (msg ^ " on line " ^ (string_of_int !line_num)))

let keywords = [
    "begin", BEGIN;
    "end", END;
    "get", GET;
    "print", PRINT;
    "extract", EXTRACT;
]

}

let blank = [' ' '\r' '\t']
let digit = ['0'-'9']
let digits = digit*
let alpha = ['a'-'z' 'A'-'Z']
let id = alpha (alpha | digit | '_')*
let str = "\"" (alpha | digit | '_' | ':' | '/' | '.' | '<' | '>' | '=' | ' ' | "\\\"")* "\""

rule sopy = parse
    | "="  { ASSIGN }
    | digits as d {
        (* parse literal *)
        LITERAL (int_of_string d)
    }
    | id as i {
        (* try keywords if not found then it's a string *)
        let l = String.lowercase_ascii i in
        try List.assoc l keywords
        with Not_found -> ID i
    }
    | str as s {
        (* try keywords if not found then it's a string *)
        let l = String.lowercase_ascii s in
        try List.assoc l keywords
        with Not_found -> STR s
    }
    | '\n' {incr line_num; sopy lexbuf} (* count new line characters *)
    | blank { sopy lexbuf } (* skipping blank characters *)
    | _ { syntax_error "couldn't identify the token" }
    | eof { EOF }