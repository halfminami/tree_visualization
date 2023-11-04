open! Base
open! Stdlib
open Data_structure.Queue

let fail = Test_func.fail
let success = Test_func.success

let%test_unit "simple" =
  let ds = init () in

  let ds = push 0 ds in
  let ds = push 1 ds in

  (match peek ds with
  | None -> fail "there should be 0 and 1"
  | Some a -> [%test_result: int] a ~expect:0);

  let ds = pop ds in

  (match peek ds with
  | None -> fail "there should be 1"
  | Some a -> [%test_result: int] a ~expect:1);

  let ds = pop ds in
  match peek ds with
  | None -> success ()
  | Some _ -> fail "there should be no item"
