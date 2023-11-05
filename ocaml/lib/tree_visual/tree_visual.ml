let ( -| ) f g x = g @@ f x

let main li : Tree_def.outputs =
  li |> List.iter (List.map string_of_int -| String.concat ", " -| print_endline);
  {
    vertices = [ (0, 1); (2, 3); (4, 5) ];
    edges = [ ((0, 1), (2, 3)); ((4, 5), (6, 7)) ];
  }

let find_root = Create_tree.find_root
