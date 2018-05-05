# Leibniz
[![Build Status](https://travis-ci.org/saulecabrera/leibniz.svg?branch=master)](https://travis-ci.org/saulecabrera/leibniz)
[![codecov](https://codecov.io/gh/saulecabrera/leibniz/branch/master/graph/badge.svg)](https://codecov.io/gh/saulecabrera/leibniz)

Leibniz is a pure erlang/elixir math expression parser and evaluator.

## Installation

```elixir
defp deps() do
  [{:leibniz, "~> 1.0.0"}]
end
```

## Usage

[Documentation](https://hexdocs.pm/leibniz/api-reference.html)

Leibniz provides two core functionalities, evaluating valid math expressions and evaluating valid math expression in a given context.

#### Examples

Evaluating simple math expressions

```elixir
Leibniz.eval("1 + 1")

{:ok, 2}

```

Evaluating math expressions in a given context

```elixir
Leibniz.eval("10 * foo", foo: 10)

{:ok, 100}
```

```elixir
Leibniz.eval("1 * baz")
{:error, "value expected for the following dependencies: baz"}
```

## TODO

- [ ] Improve errors
- [ ] Provide a `parse/1` function
- [ ] Provide a `depencies/1` function
- [ ] Add trigonometric and other math functions

## LICENSE

MIT
