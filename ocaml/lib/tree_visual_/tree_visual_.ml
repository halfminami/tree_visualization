open! Base
open! Stdlib

let string_of_d = Test_func.string_of_d
let string_of_tree_nhlrc = Test_func.string_of_tree_nhlrc
let string_of_tree_npc = Test_func.string_of_tree_npc

let%test_unit "many (stack)" =
  let open Data_structure.Stack in
  let run_test = Test_func.create ~pop ~push ~peek ~map:List.rev in
  Test_func.many_test ~init ~run_test

let%test_unit "many (queue)" =
  let open Data_structure.Queue in
  let run_test = Test_func.create ~pop ~push ~peek ~map:(fun x -> x) in
  Test_func.many_test ~init ~run_test

let%test_unit "stack and queue order" =
  let li = [ 0; 1; 2; 3; 4 ] in
  let st = ref @@ Data_structure.Stack.init () in
  let qu = ref @@ Data_structure.Queue.init () in

  List.rev li |> List.iter (fun x -> st := Data_structure.Stack.push x !st);
  li |> List.iter (fun x -> qu := Data_structure.Queue.push x !qu);

  let string_of_stack =
    let open Data_structure.Stack in
    let f ts ds = string_of_d ~peek ~pop ds ts in
    f string_of_int
  in
  let string_of_queue =
    let open Data_structure.Queue in
    let f ts ds = string_of_d ~peek ~pop ds ts in
    f string_of_int
  in

  [%test_result: string] (string_of_stack !st) ~expect:(string_of_queue !qu)
    ~message:"queue order is reversed stack"

let test_tree0 =
  [|
    [||];
    [| 4; 5 |];
    [||];
    [| 6; 7 |];
    [||];
    [| 8 |];
    [||];
    [| 9; 10; 11; 12; 0 |];
    [||];
    [||];
    [||];
    [||];
    [||];
    [| 1; 2; 3 |];
  |]

let test_tree1 =
  [|
    [| 1 |];
    [| 2 |];
    [| 3; 4; 5 |];
    [| 6 |];
    [| 7 |];
    [| 8 |];
    [| 9; 10; 11 |];
    [||];
    [| 12; 13 |];
    [||];
    [||];
    [||];
    [||];
    [||];
  |]

let cnt = 0
let sub a = Printf.sprintf "find root (%s)" @@ string_of_int a

let%test_unit [%name sub cnt] =
  match Tree_visual.find_root_opt test_tree0 with
  | None -> Test_func.fail "should find root"
  | Some i -> [%test_result: int] i ~expect:13 ~message:"root is 13"

let cnt = cnt + 1

let%test_unit [%name sub cnt] =
  match Tree_visual.find_root_opt test_tree1 with
  | None -> Test_func.fail "should find root"
  | Some i -> [%test_result: int] i ~expect:0 ~message:"root is 0"
