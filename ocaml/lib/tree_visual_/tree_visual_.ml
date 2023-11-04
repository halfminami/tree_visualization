open! Base
open! Stdlib

let%test_unit "many (stack)" =
  let open Data_structure.Stack in
  let run_test = Test_func.create ~pop ~push ~peek ~map:List.rev in
  Test_func.many_test ~init ~run_test

let%test_unit "many (queue)" =
  let open Data_structure.Queue in
  let run_test = Test_func.create ~pop ~push ~peek ~map:(fun x -> x) in
  Test_func.many_test ~init ~run_test

let%test_unit "order" =
  let li = [ 0; 1; 2; 3; 4 ] in
  let st = ref @@ Data_structure.Stack.init () in
  let qu = ref @@ Data_structure.Queue.init () in

  List.rev li |> List.iter (fun x -> st := Data_structure.Stack.push x !st);
  li |> List.iter (fun x -> qu := Data_structure.Queue.push x !qu);

  let string_of_stack =
    let open Data_structure.Stack in
    let f ts ds = Data_structure.string_of_d ~peek ~pop ds ts in
    f string_of_int
  in
  let string_of_queue =
    let open Data_structure.Queue in
    let f ts ds = Data_structure.string_of_d ~peek ~pop ds ts in
    f string_of_int
  in

  [%test_result: string] (string_of_stack !st) ~expect:(string_of_queue !qu)
    ~message:"queue order is reversed stack"
