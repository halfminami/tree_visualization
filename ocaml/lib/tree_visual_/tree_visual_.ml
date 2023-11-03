let%test "hello" =
  let () = print_endline "hello inline test!" in
  let () = Tree_visual.main () in
  Int.equal 1 0
