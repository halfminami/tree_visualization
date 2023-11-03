open Base
open Stdlib

let%test "stack" =
  let () = print_endline "hello inline test!" in
  let () = Tree_visual.main () in
  Int.equal 1 1

(* let%test_unit "testtt" = [%test_eq: int] 1 0 *)
let%test_unit "rev" =
  [%test_eq: int] 0 0;
  [%test_eq: int] 1 1;
  [%test_eq: int] 1 0;
  [%test_eq: int list] (List.rev [ 3; 2; 1 ]) [ 3; 2; 1 ]
