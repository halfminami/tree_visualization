type 'a cell =
  | Nil
  | Cell of { value : 'a; next : 'a cell ref; is_head : bool ref }

type 'a queue = { head : 'a cell; tail : 'a cell }

let init _ = { head = Nil; tail = Nil }

let push a qu =
  match qu.tail with
  | Nil ->
      let c = Cell { value = a; next = ref Nil; is_head = ref true } in
      { head = c; tail = c }
  | Cell { next; _ } ->
      let c = Cell { value = a; next = ref Nil; is_head = ref false } in
      next := c;
      { head = qu.head; tail = c }

let peek q = match q.head with Nil -> None | Cell { value; _ } -> Some value

let pop q =
  match q.head with
  | Nil -> init ()
  | Cell { next; _ } -> (
      match !next with
      | Nil -> init ()
      | Cell { is_head; _ } as cell ->
          is_head := true;
          { head = cell; tail = q.tail })
