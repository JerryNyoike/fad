let ls = [1;2;3;4;5;5;5;5;5];; (* should change to [1;2;3;4;5] *)
let ls2 = [7;8;9;9;4;3];; (* should stay the same *)


(* Remove duplicates at the end of the list *)
let rem_dups ls =
  let rec rem = function
    | [] -> []
    | x::y::xs when x = y -> rem (y::xs)
    | x :: xs -> x::xs
  in
  List.rev (rem (List.rev ls))
  

