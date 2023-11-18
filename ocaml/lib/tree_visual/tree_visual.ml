let find_root_opt = Create_tree.find_root_opt
let find_root = Create_tree.find_root
let none_tree = Tree_def.none_tree

type vertex_t = Tree_def.vertex

let make_tree = Create_tree.make_tree
let align_center = Traverse_tree.align_center

let main ar : Tree_def.outputs =
  let arr : Tree_def.pos_t array = Array.make (Array.length ar) (0., 0.) in
  let li = ref [] in

  let rec down (node : vertex_t) d =
    arr.(node.name) <- !(node.pos);
    if d <> -1 then li := (d, node.name) :: !li;
    node.children |> Array.iter (fun x -> down x node.name)
  in

  (find_root ar |> make_tree ar |> align_center |> fun x -> down x ~-1);
  { vertices = arr; edges = Array.of_list !li }
