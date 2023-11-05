type inputs = int array array

type outputs = {
  vertices : (int * int) list;
  edges : ((int * int) * (int * int)) list;
}

type vertex = {
  name : int;
  children : vertex list;
  left : int ref;
  right : int ref;
  parent : vertex;
}
