%{

open Codegen

let depth = ref 0
let depth_incr f = incr depth; f !depth
let depth_reset = depth := 0

%}

%token BEGIN END EOF
%token <string> ID
%token <string> STR
%token <string> REST
%token <int> LITERAL
%token GET PRINT EXTRACT
%token LEFTPAREN RIGHTPAREN
%token ASSIGN

%start program
%type <unit> program

%%

program:
| begin_stmt statements end_stmt EOF { raise End_of_file }
;

begin_stmt:
| BEGIN { generate_begin () }
;

end_stmt:
| END { generate_end () }
;

statements:
| { }
| statement statements { }
;

statement:
| ID ASSIGN GET lstr { generate_get $1 $4 }
| ID ASSIGN EXTRACT ID lstr lstr { generate_extract $1 $4 $5 $6 }
| PRINT ID { generate_print $2 }
;

lstr:
| STR { $1 }
;
