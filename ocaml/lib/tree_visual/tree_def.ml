type inputs = int array array

type outputs = {
  vertices : (int * int) list;
  edges : ((int * int) * (int * int)) list;
}

type vertex = {
  name : int;
  children : vertex array;
  left : int ref;
  right : int ref;
  height : int;
  parent : int option;
}

let none_tree =
  {
    name = 0;
    children = [||];
    left = ref ~-1;
    right = ref ~-1;
    height = 0;
    parent = None;
  }
