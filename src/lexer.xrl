Definitions.

CHAR         = [a-z_]
ADD_OPERATOR = (\+|-)
MUL_OPERATOR = (\*|/)
POW_OPERATOR = \^
DIGIT        = [0-9]
OPEN_PAREN   = \(
CLOSE_PAREN  = \)
WHITE        = [\s|\t]

Rules.

{CHAR}+             : {token, {identifier, TokenLine, list_to_atom(TokenChars)}}.
{ADD_OPERATOR}      : {token, {add_operator, TokenLine, list_to_atom(TokenChars)}}.
{MUL_OPERATOR}      : {token, {mul_operator, TokenLine, list_to_atom(TokenChars)}}.
{POW_OPERATOR}      : {token, {pow_operator, TokenLine, list_to_atom(TokenChars)}}.
{DIGIT}+            : {token, {int, TokenLine, list_to_integer(TokenChars)}}.
{DIGIT}+\.{DIGIT}+  : {token, {float, TokenLine, list_to_float(TokenChars)}}.
{OPEN_PAREN}        : {token, {open_paren, TokenLine, list_to_atom(TokenChars)}}.
{CLOSE_PAREN}       : {token, {close_paren, TokenLine, list_to_atom(TokenChars)}}.
{WHITE}+            : skip_token.


Erlang code.
