# Leibniz [![Build Status](https://travis-ci.org/saulecabrera/leibniz.svg?branch=master)](https://travis-ci.org/saulecabrera/leibniz)

Leibniz is a math expression parser and evaluator.

## Usage

Evaluating simple math expressions

```elixir

Leibniz.eval("1 + 1")

{:ok, 2}

```


Evaluating math expression with variables:

```elixir
Leibniz.eval("10 * foo", foo: 10)

{:ok, 100}
```

## LICENSE

MIT
