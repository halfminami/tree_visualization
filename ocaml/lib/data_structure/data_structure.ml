module type Data_t = sig
  type 'a t

  val init : 'u -> 'a t
  val push : 'a -> 'a t -> 'a t
  val peek : 'a t -> 'a option
  val pop : 'a t -> 'a t
end

module Stack : Data_t = struct
  open Ds_stack

  type 'a t = 'a stack

  let init = init
  let push = push
  let peek = peek
  let pop = pop
end

module Queue : Data_t = struct
  open Ds_queue

  type 'a t = 'a queue

  let init = init
  let push = push
  let peek = peek
  let pop = pop
end
