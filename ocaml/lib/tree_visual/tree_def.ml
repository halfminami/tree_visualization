type inputs = int array array
type outputs = { vertices : (int * int) array }

type vertex = {
  name : int;
  children : vertex array;
  left : int ref;
  right : int ref;
  height : int;
  parent : int option;
  pos : (int * int) ref;
}

let none_tree =
  {
    name = 0;
    children = [||];
    left = ref 0;
    right = ref 0;
    height = 0;
    parent = None;
    pos = ref (0, 0);
  }
