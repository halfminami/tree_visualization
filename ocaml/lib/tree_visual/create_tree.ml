let find_root_opt (ar : Tree_def.inputs) =
  let arr = 0 |> Array.make @@ Array.length ar in
  (* tree root has no edge's head *)
  ar |> Array.iter (fun x -> x |> Array.iter (fun x -> arr.(x) <- arr.(x) + 1));
  arr |> Array.find_index (fun x -> x = 0)

let find_root ar =
  match find_root_opt ar with
  | None -> failwith "could not find root: input may not be a tree"
  | Some a -> a

let make_tree (d : int) (ar : Tree_def.inputs) arr =
  let rec down i l p =
    let v : Tree_def.vertex =
      {
        name = i;
        children = ar.(i) |> Array.mapi (fun k x -> down x (l + k) i);
        left = ref l;
        right = ref l;
        parent = (if p = -1 then None else Some p);
      }
    in
    arr.(i) <- v;
    v
  in

  down d 0 ~-1
