(* wanted to include in each module with type instantiated *)
let string_of_d ~peek ~pop =
  let to_string d to_s =
    let open Printf in
    let rec f d =
      match peek d with
      | None -> "*"
      | Some a -> sprintf "%s, (%s)" (to_s a) (f @@ pop d)
    in
    sprintf "(%s)" @@ f d
  in
  to_string

module type Data_t = sig
  type 'a t

  val init : 'u -> 'a t
  val push : 'a -> 'a t -> 'a t
  val peek : 'a t -> 'a option
  val pop : 'a t -> 'a t
  (* val to_string : 'a t -> ('a -> string) -> string *)
end

module Stack : Data_t = struct
  open Ds_stack

  type 'a t = 'a stack

  let init = init
  let push = push
  let peek = peek
  let pop = pop
  (* let to_string = string_of_d ~peek ~pop *)
end

module Queue : Data_t = struct
  open Ds_queue

  type 'a t = 'a queue

  let init = init
  let push = push
  let peek = peek
  let pop = pop
end
