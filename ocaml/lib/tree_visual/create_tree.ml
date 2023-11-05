let find_root (ar : Tree_def.inputs) =
  let arr = 0 |> Array.make @@ Array.length ar in
  (* tree root has no edge's head *)
  ar |> Array.iter (fun x -> x |> Array.iter (fun x -> arr.(x) <- arr.(x) + 1));
  arr |> Array.find_index (fun x -> x = 0)

(* let make_tree (d:int) (ar : Tree_def.inputs) =
   let rec down i l  p:Tree_def.vertex =
   {
      name=i;
      children= Array.map
   } *)
