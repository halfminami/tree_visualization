(* open Ds_stack *)
(* open Ds_queue *)
open Data_structure.Stack

let to_string = Data_structure.string_of_d ~peek ~pop

let main _ =
  let ds = init () in
  let ds = push 0 ds in
  let ds = push 1 ds in
  let ds = push 2 ds in
  print_endline @@ to_string ds string_of_int;
  let ds2 = ref ds in
  while match peek !ds2 with None -> false | Some _ -> true do
    (match peek !ds2 with
    | None -> failwith "ohno"
    | Some a -> print_endline @@ string_of_int a);
    ds2 := pop !ds2;
    print_endline @@ to_string !ds2 string_of_int
  done;
  (* unchanged! *)
  print_endline @@ to_string ds string_of_int
