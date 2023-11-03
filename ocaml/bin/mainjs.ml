open Js_of_ocaml

let _ =
  Js.export "treeGrid"
    (object%js
       method main = Tree_visual.main
    end)
