let () =
  let li = [ 0; 1; 2; 3 ] in
  let st = ref @@ Data_structure.Stack.init () in
  let qu = ref @@ Data_structure.Queue.init () in
  li
  |> List.iter (fun x ->
         st := Data_structure.Stack.push x !st;
         qu := Data_structure.Queue.push x !qu);
  let string_of_stack =
    let open Data_structure.Stack in
    let f ts ds = Tree_visual_.string_of_d ~peek ~pop ds ts in
    f string_of_int
  in
  let string_of_queue =
    let open Data_structure.Queue in
    let f ts ds = Tree_visual_.string_of_d ~peek ~pop ds ts in
    f string_of_int
  in
  print_endline "stack is:";
  print_endline @@ string_of_stack !st;
  print_endline "queue is:";
  print_endline @@ string_of_queue !qu;

  print_newline ();
  print_endline "create tree:";
  let create tree = Tree_visual.make_tree tree (Tree_visual.find_root tree) in
  let run tree =
    print_endline (create tree |> Tree_visual_.string_of_tree_nhlrc)
  in
  let tree = Tree_visual_.test_tree0 in
  print_endline "test_tree0";
  run tree;
  let tree = Tree_visual_.test_tree1 in
  print_endline "test_tree1";
  run tree;

  print_newline ();
  print_endline "align center tree:";
  let run tree =
    print_endline
      (Tree_visual.align_center (create tree) |> Tree_visual_.string_of_tree_npc)
  in
  let tree = Tree_visual_.test_tree0 in
  print_endline "test_tree0";
  run tree;
  let tree = Tree_visual_.test_tree1 in
  print_endline "test_tree1";
  run tree;

  print_newline ();
  print_endline "main:";
  let run tree = Tree_visual.main tree in
  let prints arr2 =
    arr2
    |> Array.map (fun (x, y) ->
           Printf.sprintf "(%s, %s)" (string_of_int x) (string_of_int y))
    |> Array.to_list |> String.concat ", " |> print_endline
  in
  let tree = Tree_visual_.test_tree0 in
  print_endline "test_tree0";
  prints (run tree).vertices;
  let tree = Tree_visual_.test_tree1 in
  print_endline "test_tree1";
  prints (run tree).vertices;

  ()
