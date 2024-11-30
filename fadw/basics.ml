type nat = int


let length : 'a list -> nat =
  fun l -> List.fold_left (fun x y -> x + y) 0 l;;

(*
  processes data as it comes in.

  A scan produces the list of accumulators as the list is processed.
 *)
let rec scanl (f: ('b -> 'a -> 'b)) (e: 'b) (ls: 'a list) : 'b list =
  match ls with
  | [] -> [e]
  | x::xs -> e :: scanl f (f e x) xs;;

(* Inductive vs Rescursive definitions *)
(*
  The nature of recursion is different in different functions
  Functions such as map and filter use _structural_ recursion; they follow the
  structure of a list and the cons operator. A clause exists for the base case (empty list)
  and a recursive case for non empty list. This is referred to as _inductive_ recursion.

  *Most inductive definitions can be expressed as instances of fold_right*

  Another example of inductive recursion is finding the permutations of a list
 *)
let rec inserts (x: 'a) (ls: 'a list) : 'a list list =
  match ls with
  | [] -> [[x]]
  | y::ys -> (x :: y :: ys) :: List.map (fun n -> y::n) (inserts x ys)

let rec perms (ls: 'a list) = match ls with
  | [] -> [[]]
  | x::xs ->
     let ys = perms xs in
     let zs = List.map (inserts x) ys in
     List.concat zs;;

(*
  A different version of perms could use foldr
 *)
let ($) f g x = f(g x)

let flip f x y = f y x

let perms' =
  let step x xss = List.concat_map (inserts x) xss in  
  flip (List.fold_right step) [[]]

let perms'' = flip (List.fold_right (List.concat_map $ inserts)) [[]];;

(*
  We can also express the permutation function with non inductive recursion
 *)
let rec perms_2 = function
  | [] -> [[]]
  | xs ->
     let p = picks xs in
     List.concat_map (fun (x, ys) -> List.map (fun zs -> x :: zs) (perms_2 ys)) p

     
let rec picks = function
  | [] -> []
  | x :: xs ->
     (x, xs) :: List.map (fun (y, ys) -> (y, x::ys)) (picks xs);;


(*
  Divide and conquer algorithms are usually recursive in nature while greedy & thinning
  algorithms are usually inductive.

  Different solutions for problems arise simply because there are different but equally clear
  definitions of one or more of the basic functions describing the solution.
 *)

(*
  Imperative programming relies on loops in addition to recursion, we can define loops in
  functional programming too
 *)
let rec until (p: 'a -> bool) (f: 'a -> 'a) (x: 'a) : 'a =
  if p x then x else until p f (f x)

let while_loop p = until (not p);;

(* we can also define functional versions of for loops *)
