open! Base
open! Stdlib

let fail message = [%test_pred: unit] (fun _ -> false) () ~message
let success () = ()

let create ~pop ~push ~peek ~map =
  let test li ds =
    List.iter (fun x -> ds := push x !ds) li;
    [%test_result: int option list]
      (li
      |> List.map @@ fun _ ->
         let pk = peek !ds in
         ds := pop !ds;
         pk)
      ~expect:(map li |> List.map (fun x -> Some x))
      ~message:"series of push and pop test"
  in
  test

let many_test ~run_test ~init =
  let ds = ref @@ init () in
  run_test [ 0; 1; 2 ] ds;
  run_test [ 3; 4; 5 ] ds;
  run_test [ 10; 11; 12 ] ds

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

let rec string_of_tree
    ({
       name;
       children;
       left = { contents = l };
       right = { contents = r };
       height;
       _;
     } :
      Tree_visual.vertex_t) =
  (* name:<height>[left|right] =>(children) *)
  Printf.sprintf "%s:<%s>[%s|%s] =>(%s)" (string_of_int name)
    (string_of_int height) (string_of_int l) (string_of_int r)
    (Array.map string_of_tree children |> Array.to_list |> String.concat ", ")
