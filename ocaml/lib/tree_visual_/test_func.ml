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
