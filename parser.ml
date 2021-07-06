type token =
  | BEGIN
  | END
  | EOF
  | ID of (string)
  | STR of (string)
  | REST of (string)
  | LITERAL of (int)
  | GET
  | PRINT
  | EXTRACT
  | LEFTPAREN
  | RIGHTPAREN
  | ASSIGN
  | PIPE

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"

open Codegen

let depth = ref 0
let depth_incr f = incr depth; f !depth
let depth_reset = depth := 0

let stack = ref (Stack.create ())
let () = Stack.push "END2" !stack

let push_var var = Stack.push var !stack
let pop_var () = Stack.pop !stack

# 34 "parser.ml"
let yytransl_const = [|
  257 (* BEGIN *);
  258 (* END *);
    0 (* EOF *);
  263 (* GET *);
  264 (* PRINT *);
  265 (* EXTRACT *);
  266 (* LEFTPAREN *);
  267 (* RIGHTPAREN *);
  268 (* ASSIGN *);
  269 (* PIPE *);
    0|]

let yytransl_block = [|
  259 (* ID *);
  260 (* STR *);
  261 (* REST *);
  262 (* LITERAL *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\004\000\003\000\003\000\003\000\005\000\005\000\
\005\000\005\000\006\000\006\000\006\000\008\000\008\000\007\000\
\000\000"

let yylen = "\002\000\
\004\000\001\000\001\000\000\000\002\000\002\000\004\000\002\000\
\006\000\002\000\000\000\002\000\002\000\004\000\002\000\001\000\
\002\000"

let yydefred = "\000\000\
\000\000\000\000\002\000\017\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\016\000\008\000\010\000\003\000\000\000\
\000\000\005\000\006\000\000\000\000\000\000\000\001\000\015\000\
\000\000\013\000\012\000\007\000\000\000\000\000\000\000\014\000\
\009\000"

let yydgoto = "\002\000\
\004\000\005\000\009\000\016\000\010\000\019\000\013\000\020\000"

let yysindex = "\002\000\
\006\255\000\000\000\000\000\000\010\255\003\255\017\255\019\255\
\021\255\254\254\007\255\000\000\000\000\000\000\000\000\024\000\
\011\255\000\000\000\000\254\254\017\255\022\255\000\000\000\000\
\017\255\000\000\000\000\000\000\017\255\017\255\017\255\000\000\
\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\024\255\000\000\000\000\000\000\
\000\000\024\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\024\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000"

let yygindex = "\000\000\
\000\000\000\000\248\255\000\000\000\000\007\000\235\255\000\000"

let yytablesize = 27
let yytable = "\028\000\
\006\000\018\000\001\000\030\000\007\000\008\000\003\000\031\000\
\032\000\033\000\017\000\026\000\006\000\021\000\011\000\022\000\
\007\000\008\000\024\000\025\000\012\000\014\000\015\000\023\000\
\029\000\004\000\027\000"

let yycheck = "\021\000\
\003\001\010\000\001\000\025\000\007\001\008\001\001\001\029\000\
\030\000\031\000\013\001\020\000\003\001\007\001\012\001\009\001\
\007\001\008\001\008\001\009\001\004\001\003\001\002\001\000\000\
\003\001\002\001\020\000"

let yynames_const = "\
  BEGIN\000\
  END\000\
  EOF\000\
  GET\000\
  PRINT\000\
  EXTRACT\000\
  LEFTPAREN\000\
  RIGHTPAREN\000\
  ASSIGN\000\
  PIPE\000\
  "

let yynames_block = "\
  ID\000\
  STR\000\
  REST\000\
  LITERAL\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'begin_stmt) in
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'statements) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'end_stmt) in
    Obj.repr(
# 32 "parser.mly"
                                     ( raise End_of_file )
# 134 "parser.ml"
               : unit))
; (fun __caml_parser_env ->
    Obj.repr(
# 36 "parser.mly"
        ( generate_begin () )
# 140 "parser.ml"
               : 'begin_stmt))
; (fun __caml_parser_env ->
    Obj.repr(
# 40 "parser.mly"
      ( generate_end () )
# 146 "parser.ml"
               : 'end_stmt))
; (fun __caml_parser_env ->
    Obj.repr(
# 44 "parser.mly"
  ( )
# 152 "parser.ml"
               : 'statements))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'statement) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'statements) in
    Obj.repr(
# 45 "parser.mly"
                       ( )
# 160 "parser.ml"
               : 'statements))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'statement) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'pipe_statements) in
    Obj.repr(
# 46 "parser.mly"
                            ( finish_pipe (pop_var ()) )
# 168 "parser.ml"
               : 'statements))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'lstr) in
    Obj.repr(
# 50 "parser.mly"
                     ( push_var _1; generate_get _1 _4 )
# 176 "parser.ml"
               : 'statement))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'lstr) in
    Obj.repr(
# 51 "parser.mly"
           ( generate_get_pipe _2 )
# 183 "parser.ml"
               : 'statement))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'lstr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'lstr) in
    Obj.repr(
# 52 "parser.mly"
                                 ( generate_extract _1 _4 _5 _6 )
# 193 "parser.ml"
               : 'statement))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 53 "parser.mly"
           ( generate_print _2 )
# 200 "parser.ml"
               : 'statement))
; (fun __caml_parser_env ->
    Obj.repr(
# 57 "parser.mly"
  ( )
# 206 "parser.ml"
               : 'pipe_statements))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'pipe_statement) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'pipe_statements) in
    Obj.repr(
# 58 "parser.mly"
                                 ( )
# 214 "parser.ml"
               : 'pipe_statements))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'pipe_statement) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'statements) in
    Obj.repr(
# 59 "parser.mly"
                            ( )
# 222 "parser.ml"
               : 'pipe_statements))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'lstr) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'lstr) in
    Obj.repr(
# 63 "parser.mly"
                         ( generate_extract_pipe _3 _4 )
# 230 "parser.ml"
               : 'pipe_statement))
; (fun __caml_parser_env ->
    Obj.repr(
# 64 "parser.mly"
             ( generate_print_pipe () )
# 236 "parser.ml"
               : 'pipe_statement))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 68 "parser.mly"
      ( _1 )
# 243 "parser.ml"
               : 'lstr))
(* Entry program *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let program (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : unit)
