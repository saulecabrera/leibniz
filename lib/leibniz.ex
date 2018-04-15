defmodule Leibniz do

  @moduledoc """
  Leibniz is a math expression parser and evaluator.
  """

  @doc ~S"""
  Evaluates a valid math expression interpolating any given values.

  ## Examples
  
      iex> Leibniz.eval("2 * 10 / 2")
      {:ok, 10.0}

      iex> Leibniz.eval("2 * foo + bar - baz", foo: 5.3, bar: 10, baz: 3)
      {:ok, 17.6}

      iex> Leibniz.eval("2 * x + y")
      {:error, "value expected for the following dependencies: x,y"}
  """

  @spec eval(String.t, Keyword.t(number)) :: {:ok, number} | {:error, term} 
  def eval(expr, vars \\ []) do
    with {:ok, ast} <- parse(expr),
         :ok <- verify_dependencies(dependecies(ast), Keyword.keys(vars)) do
      {:ok, match(ast, vars)}
    else
      {:error, e} -> {:error, e} 
    end
  end

  def parse(expr) do
    with {:ok, tokens, _} <- expr |> to_charlist() |> :lexer.string(),
         {:ok, ast} <- :parser.parse(tokens) do
      {:ok, ast}
    else
      {:error, e, _} -> {:error, e}
      {:error, e} -> {:error, e}
    end
  end

  defp match(token, vars) when is_number(token), do: token

  defp match(token, vars) when is_atom(token) do
    Keyword.get(vars, token)
  end

  defp match({:+, lhs, rhs}, vars), do: match(lhs, vars) + match(rhs, vars)
  defp match({:-, lhs, rhs}, vars), do: match(lhs, vars) - match(rhs, vars)
  defp match({:*, lhs, rhs}, vars), do: match(lhs, vars) * match(rhs, vars)
  defp match({:/, lhs, rhs}, vars), do: match(lhs, vars) / match(rhs, vars)

  defp dependecies({_, lhs, rhs}) do
    do_dependecies(lhs, []) ++ do_dependecies(rhs, [])
  end

  defp dependecies(_), do: []

  defp do_dependecies(node, acc) when is_atom(node), do: [node] ++ acc

  defp do_dependecies({_, lhs, rhs}, acc) do
    do_dependecies(lhs, acc) ++ do_dependecies(rhs, acc)
  end

  defp do_dependecies(_, acc), do: acc

  defp verify_dependencies(required, actual) do
    case required -- actual do
      [] -> :ok
      missing -> {:error, "value expected for the following dependencies: #{Enum.join(missing, ",")}"}
    end
  end
end
