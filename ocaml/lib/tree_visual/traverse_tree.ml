let the_value ar cm init =
  let v = ref init in
  ar |> Array.iter (fun x -> v := if cm x !v then x else !v);
  !v

let get_first (x, _) = x

let align_center (top : Tree_def.vertex) =
  let open Data_structure in
  let st = ref @@ Stack.init () in

  (* right first BFS *)
  let qu = ref @@ Queue.init () in
  qu := Queue.push top !qu;
  st := Stack.push top !st;

  while Queue.peek !qu <> None do
    (match Queue.peek !qu with
    | None -> failwith "ohno"
    | Some a ->
        a.children
        |> Array.iteri (fun i _ ->
               let indx = Array.length a.children - i - 1 in
               st := Stack.push a.children.(indx) !st;
               qu := Queue.push a.children.(indx) !qu));
    qu := Queue.pop !qu
  done;

  (* align center *)
  while Stack.peek !st <> None do
    (match Stack.peek !st with
    | None -> failwith "ohno"
    | Some a ->
        (* if has children, consider *)
        let minl =
          if Array.length a.children > 0 then
            get_first
              !((the_value a.children
                   (fun x y -> get_first !(x.pos) < get_first !(y.pos))
                   a.children.(0))
                 .pos)
          else !(a.left)
        in
        let maxr =
          if Array.length a.children > 0 then
            get_first
              !((the_value a.children
                   (fun x y -> get_first !(x.pos) > get_first !(y.pos))
                   a.children.(0))
                 .pos)
          else !(a.right)
        in

        let posx = minl +. ((maxr -. minl) /. 2.) in
        a.pos := (posx, a.height));
    st := Stack.pop !st
  done;
  top
