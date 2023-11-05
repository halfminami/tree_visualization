open Js_of_ocaml

let map2 map f1 f2 a = map f2 @@ f1 a

let _ =
  Js.export "treeGrid"
    (object%js
       method main (ar : int Js.js_array Js.t Js.js_array Js.t) =
         map2 Array.map Js.to_array Js.to_array ar
         (* |> map2 List.map Array.to_list Array.to_list *)
         |> Tree_visual.main
         |> fun { vertices } ->
         object%js
           val vertices =
             vertices
             |> Array.map (fun (a, b) -> [| a; b |])
             |> map2 Js.array_map Js.array Js.array
         end
    end)
