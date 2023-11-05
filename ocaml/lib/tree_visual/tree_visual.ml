let ( -| ) f g x = g @@ f x

let main ar : Tree_def.outputs =
  ar |> ignore;
  {
    vertices = [ (0, 1); (2, 3); (4, 5) ];
    edges = [ ((0, 1), (2, 3)); ((4, 5), (6, 7)) ];
  }

let find_root_opt = Create_tree.find_root_opt
let find_root = Create_tree.find_root
let none_tree = Tree_def.none_tree

type vertex_t = Tree_def.vertex

let make_tree = Create_tree.make_tree
let align_center = Traverse_tree.align_center
