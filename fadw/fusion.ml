(*
  the most powerful technique for constructing efficient algorithms
  lies in the ability to fuse two computations together eg

  a) map f . map g       = map (f.g)
  b) concatMap f . map g = concatMat (f.g)
  c) foldr f e . map g   = foldr (f.g) e

  equation a => the 2-step process of applying one function to every element of a list then
                applying a second function to every element of the result can be replaced by
                a one-step traversal in which the composition of the two functions is applied 
                to each element.

           b => this is an instance of equation a
           c => this is also an instance of when two traversals can be replaced by a single
                traversal

  another fusion law is

  foldr f e . concat = ?

  foldr f e (xs ++ ys) = ??

  to solve these two equations we appeal to the master fusion rule (the fusion rule for
  foldr)

    h (foldr f e xs) = foldr g (h e) xs

  for all finite lists provided

    h (f x y) = g x (h y)
  
  for all x and y

  returning to our equations

  foldr f e . concat   = foldr f e . (foldr @ [])
                       = foldr @ (foldr f e []) xs

  foldr f e (xs ++ ys) = foldr f (foldr f e ys) xs

 *)
