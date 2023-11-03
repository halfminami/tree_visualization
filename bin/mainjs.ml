open Js_of_ocaml

let () = Tree_visual.main ()
let () = print_endline "hello js of ocaml!!"

let _ =
  Js.export "treeGrid"
    (object%js
       method main = Tree_visual.main
    end)
