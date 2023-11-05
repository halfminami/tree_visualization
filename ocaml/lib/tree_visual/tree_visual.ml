let find_root_opt = Create_tree.find_root_opt
let find_root = Create_tree.find_root
let none_tree = Tree_def.none_tree

type vertex_t = Tree_def.vertex

let make_tree = Create_tree.make_tree
let align_center = Traverse_tree.align_center

let main ar : Tree_def.outputs =
  let arr = Array.make (Array.length ar) (0, 0) in

  let rec down (node : vertex_t) =
    arr.(node.name) <- !(node.pos);
    node.children |> Array.iter down
  in

  find_root ar |> make_tree ar |> align_center |> down;
  { vertices = arr }
