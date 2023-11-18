type x_t = float
type y_t = float
type pos_t = x_t * y_t
type inputs = int array array
type outputs = { vertices : pos_t array; edges : (int * int) array }

type vertex = {
  name : int;
  children : vertex array;
  left : x_t ref;
  right : x_t ref;
  height : y_t;
  parent : int option;
  pos : pos_t ref;
}

let none_tree =
  {
    name = 0;
    children = [||];
    left = ref 0.;
    right = ref 0.;
    height = 0.;
    parent = None;
    pos = ref (0., 0.);
  }
