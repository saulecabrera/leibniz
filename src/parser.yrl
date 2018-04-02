Nonterminals
  expr.

Terminals
  identifier add_operator mul_operator pow_operator int float open_paren close_paren.

Rootsymbol expr.

Left 100 open_paren.
Left 200 add_operator.
Left 300 mul_operator.
Left 400 pow_operator.


expr -> open_paren expr close_paren : {unwrap('$1'), '$2'}.
expr -> expr add_operator expr : {unwrap('$2'), '$1', '$3'}.
expr -> expr mul_operator expr : {unwrap('$2'), '$1', '$3'}.
expr -> expr pow_operator expr : {unwrap('$2'), '$1', '$3'}.

expr -> int : unwrap('$1').
expr -> float : unwrap('$1').
expr -> identifier : unwrap('$1').

Erlang code.

unwrap({_, _, V}) -> V.
