defmodule LeibnizTest do
  use ExUnit.Case
  doctest Leibniz

  test "greets the world" do
    assert Leibniz.hello() == :world
  end
end
