%{

open Codegen

let depth = ref 0
let depth_incr f = incr depth; f !depth
let depth_reset = depth := 0

let stack = ref (Stack.create ())
let () = Stack.push "END2" !stack

let push_var var = Stack.push var !stack
let pop_var () = Stack.pop !stack

%}

%token BEGIN END EOF
%token <string> ID
%token <string> STR
%token <string> REST
%token <int> LITERAL
%token GET PRINT EXTRACT
%token LEFTPAREN RIGHTPAREN
%token ASSIGN PIPE

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
| statement pipe_statements { finish_pipe (pop_var ()) }
;

statement:
| ID ASSIGN GET lstr { push_var $1; generate_get $1 $4 }
| GET lstr { generate_get_pipe $2 }
| ID ASSIGN EXTRACT ID lstr lstr { generate_extract $1 $4 $5 $6 }
| PRINT ID { generate_print $2 }
;

pipe_statements:
| { }
| pipe_statement pipe_statements { }
| pipe_statement statements { }
;

pipe_statement:
| PIPE EXTRACT lstr lstr { generate_extract_pipe $3 $4 }
| PIPE PRINT { generate_print_pipe () }
;

lstr:
| STR { $1 }
;
