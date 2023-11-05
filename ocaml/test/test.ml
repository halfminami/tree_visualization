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

  print_endline "create tree";
  let run tree =
    let mem = Array.make (Array.length tree) Tree_visual.none_tree in
    print_endline
      (Tree_visual.make_tree (Tree_visual.find_root tree) tree mem
      |> Tree_visual_.string_of_tree)
  in
  let tree = Tree_visual_.test_tree0 in
  print_endline "test_tree0";
  run tree;
  let tree = Tree_visual_.test_tree1 in
  print_endline "test_tree1";
  run tree
