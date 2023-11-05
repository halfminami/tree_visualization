let find_root_opt (ar : Tree_def.inputs) =
  let arr = 0 |> Array.make @@ Array.length ar in
  (* tree root has no edge's head *)
  ar |> Array.iter (fun x -> x |> Array.iter (fun x -> arr.(x) <- arr.(x) + 1));
  arr |> Array.find_index (fun x -> x = 0)

let find_root ar =
  match find_root_opt ar with
  | None -> failwith "could not find root: input may not be a tree"
  | Some a -> a

let make_tree (d : int) (nodes : Tree_def.inputs) mem =
  let rec down i l p h =
    let chs = Array.make (Array.length nodes.(i)) Tree_def.none_tree in
    let maxl = ref l in
    nodes.(i)
    |> Array.iteri (fun k x ->
           (* parent with only one child is not changing its width;
              else since maxl is updating, add 1 *)
           let ret = down x (!maxl + if k = 0 then 0 else 1) i (h + 1) in
           match ret with
           | v, vl ->
               maxl := if !maxl > vl then !maxl else vl;
               chs.(k) <- v);

    let v : Tree_def.vertex =
      {
        name = i;
        children = chs;
        left = ref l;
        right = maxl;
        height = h;
        parent = (if p = -1 then None else Some p);
      }
    in
    mem.(i) <- v;
    (v, !maxl)
  in

  match down d 0 ~-1 0 with v, _ -> v
