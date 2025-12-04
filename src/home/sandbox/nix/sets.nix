# run with nix repl <basics.nix

{} # empty set
{ x = 1; y = "hello"; }

let
   james = { surname = dad.surname; age = 26;             };
   dad   = { surname = "fisher";    age = james.age + 28; };
 in
   { james = james; dad = dad; } # keys not evaluated by default because recursion

:p let
   james = { surname = dad.surname; age = 26;             };
   dad   = { surname = "fisher";    age = james.age + 28; };
 in
   { james = james; dad = dad; } # :p forces deep evaluation

:p rec {
  james = { surname = dad.surname; age = 26;             };
  dad   = { surname = "fisher";    age = james.age + 28; };
 } # same, but using special 'rec' syntax

let 
   math = { 
      div = x: y: x / y; 
      add = x: y: x + y;
      mult = x: y: x * y;
   };
in {
  div10by5 = math.div 10 5;
  add10and5 = math.add 10 5;
  mult10by5 = with math; mult 10 5; # with brings set into scope
} # sets of functions

builtins # set of builtins (module)
builtins.attrNames # builtin function: primop
builtins.attrNames {x = 1; y=2; }
builtins.tail [ 1 2 3 ]
builtins.head [ 1 2 3 ]
