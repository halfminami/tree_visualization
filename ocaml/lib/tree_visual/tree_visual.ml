let ( -| ) f g x = g @@ f x

let main li : Tree_def.outputs =
  li
  |> List.iter
       (List.map (fun x -> string_of_int x)
       -| String.concat ", " -| print_endline);
  {
    vertices = [ (0, 1); (2, 3); (4, 5) ];
    edges = [ ((0, 1), (2, 3)); ((4, 5), (6, 7)) ];
  }
