# run with nix repl <basics.nix

# https://nixos.wiki/wiki/Nix_by_example

42
"string"
/full/path
./relative/path

1+1
"string" + "concat"

"hello" + 6 # generates error
abort "a manual error"

[ 1 (1+1) "three" ] # lists, need the () around the expression

x: x*x # function/lambda, but they can only have one argument
(x: x*x) 9 # to call a function, function arg

x: y: (x / y) # multi-arg function are nested functions
(x: y: x / y) 10 5 # divide 10 by 5

let 
  div = x: y: x / y; 
  ten = 10;
in
  div ten 5 # let expressions allow you to name functions

let
  abs = x: if x < 0 then -x else x; # if clause
in
  [ (abs 1) (abs 0) (abs (-1)) ] # need () around -1 otherwise nix tries (abs - 1)

[ 1 2 ] ++ [ 3 ] # list concatenation

import ./two.int.nix # import substitues contents of file as expression
import ./two.string.nix
