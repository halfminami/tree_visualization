open Js_of_ocaml

let _ =
  Js.export "treeGrid"
    (object%js
       method main _ = print_endline "hello ocaml!"
    end)
