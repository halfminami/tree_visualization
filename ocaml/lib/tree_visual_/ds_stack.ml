open! Base
open! Stdlib
open Data_structure.Stack

let fail = Test_func.fail
let success = Test_func.success

let%test_unit "simple" =
  let ds = init () in

  let ds = push 0 ds in
  let ds = push 1 ds in

  (match peek ds with
  | None -> fail "there should be 1 and 0"
  | Some a -> [%test_result: int] a ~expect:1 ~message:"last in");

  let ds = pop ds in

  (match peek ds with
  | None -> fail "there should be 0"
  | Some a -> [%test_result: int] a ~expect:0 ~message:"last in");

  let ds = pop ds in
  match peek ds with
  | None -> success ()
  | Some _ -> fail "there should be no item"
