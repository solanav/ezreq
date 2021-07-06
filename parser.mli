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

val program :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> unit
