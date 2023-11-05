let find_root (li : Tree_def.inputs) =
  let arr = 0 |> Array.make @@ List.length li in
  (* tree root has no edge's head *)
  li |> List.iter (fun x -> x |> List.iter (fun x -> arr.(x) <- arr.(x) + 1));
  arr |> Array.find_index (fun x -> x = 0)
