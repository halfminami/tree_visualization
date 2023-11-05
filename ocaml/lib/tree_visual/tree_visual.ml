let ( -| ) f g x = g @@ f x

let main ar : Tree_def.outputs =
  ar |> ignore;
  {
    vertices = [ (0, 1); (2, 3); (4, 5) ];
    edges = [ ((0, 1), (2, 3)); ((4, 5), (6, 7)) ];
  }

let find_root = Create_tree.find_root
