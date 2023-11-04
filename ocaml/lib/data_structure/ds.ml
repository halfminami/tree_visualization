let string_of_d ~peek ~pop =
  let to_string d to_s =
    let open Printf in
    let rec f d =
      match peek d with
      | None -> "*"
      | Some a -> sprintf "%s, (%s)" (to_s a) (f @@ pop d)
    in
    sprintf "(%s)" @@ f d
  in
  to_string
