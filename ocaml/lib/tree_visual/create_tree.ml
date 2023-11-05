let find_root_opt (nodes : Tree_def.inputs) =
  let arr = 0 |> Array.make @@ Array.length nodes in
  (* tree root has no edge's head *)
  nodes
  |> Array.iter (fun a -> a |> Array.iter (fun ni -> arr.(ni) <- arr.(ni) + 1));
  arr |> Array.find_index (fun cnt -> cnt = 0)

let find_root ar =
  match find_root_opt ar with
  | None -> failwith "could not find root: input may not be a tree"
  | Some a -> a

let make_tree (d : int) (nodes : Tree_def.inputs) mem =
  let rec down nodes_index l par h =
    let chs =
      Array.make (Array.length nodes.(nodes_index)) Tree_def.none_tree
    in
    let maxl = ref l in
    nodes.(nodes_index)
    |> Array.iteri (fun k x ->
           (* parent with only one child is not changing its width;
              else since maxl is updating, add 1 *)
           let ret =
             down x (!maxl + if k = 0 then 0 else 1) nodes_index (h + 1)
           in
           match ret with
           | v, vl ->
               maxl := if !maxl > vl then !maxl else vl;
               chs.(k) <- v);

    let v : Tree_def.vertex =
      {
        name = nodes_index;
        children = chs;
        left = ref l;
        right = maxl;
        height = h;
        parent = (if par = -1 then None else Some par);
        pos = ref (l, h);
      }
    in
    mem.(nodes_index) <- v;
    (v, !maxl)
  in

  match down d 0 ~-1 0 with v, _ -> v
