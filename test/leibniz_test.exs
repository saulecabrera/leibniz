defmodule LeibnizTest do
  use ExUnit.Case
  doctest Leibniz

  test "eval/2 evaluates a valid math expression and returns the result" do
    assert Leibniz.eval("2 + 2") == {:ok, 4}
    assert Leibniz.eval("2 * 2") == {:ok, 4}
    assert Leibniz.eval("2 / 2") == {:ok, 1}
    assert Leibniz.eval("2 - 2") == {:ok, 0}
  end

  test "eval/2 returns {:error, reason} when an invalid expression is given" do
    assert {:error, _} = Leibniz.eval("2 *")
    assert {:error, _} = Leibniz.eval("4 % 2")
  end

  test "eval/2 evaluates a valid math expression interpolating variables" do
    assert Leibniz.eval("2 * foo + bar", foo: 5, bar: 7) == {:ok, 17} 

    variable = 100
    assert Leibniz.eval("2 * variable", variable: variable) == {:ok, 200}
  end

  test "eval/2 returns {:error, reason} when a math expression with missing dependencies is given" do
    reason = "value expected for the following dependencies: foo,bar"
    assert {:error, ^reason} = Leibniz.eval("2 * foo * bar * baz", baz: 3)
  end
end
