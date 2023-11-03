type 'a stack = Nil | Cell of ('a * 'a stack)

let init _ = Nil
let push a st = Cell (a, st)
let peek st = match st with Nil -> None | Cell (a, _) -> Some a
let pop st = match st with Nil -> init () | Cell (_, s) -> s
