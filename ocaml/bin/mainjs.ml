open Js_of_ocaml

let map2 map f1 f2 a = map f2 @@ f1 a

let _ =
  Js.export "treeGrid"
    (object%js
       method main (ar : int Js.js_array Js.t Js.js_array Js.t) =
         map2 Array.map Js.to_array Js.to_array ar
         (* |> map2 List.map Array.to_list Array.to_list *)
         |> Tree_visual.main
         |> fun { vertices; edges } ->
         object%js
           val vertices =
             vertices
             |> List.map (fun (a, b) -> [ a; b ])
             |> map2 Array.map Array.of_list Array.of_list
             |> map2 Js.array_map Js.array Js.array

           val edges =
             edges
             |> List.map (fun ((a, b), (c, d)) ->
                    [ Js.array [| a; b |]; Js.array [| c; d |] ])
             |> map2 Array.map Array.of_list Array.of_list
             |> map2 Js.array_map Js.array Js.array
         end
    end)
