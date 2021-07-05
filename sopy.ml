(* compiling *)
let compile f =
        let out = (Filename.remove_extension f) in
        let out_chan = open_out (out ^ ".py")
        and lexbuf = Lexing.from_channel (open_in f) in
        try
            let rec parse () =
                Parser.program Lexer.sopy lexbuf; parse () in
            Codegen.set_chan out_chan;
            ignore(parse ());
        with
          End_of_file ->
            begin
                close_out out_chan;
            end
        | Lexer.Syntax_error s ->
            print_string s;
            exit 1

let help () = print_string "./sopy <file>\n"

let () = if Array.length Sys.argv != 2 then help ()
         else
             let file = Array.get Sys.argv 1 in
             Format.printf "compiling %s\n" file;
             Format.print_flush ();
             compile file
