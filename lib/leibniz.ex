defmodule Leibniz do

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
      missing -> {:error, "value expected for the following dependecies: #{Enum.join(missing, ",")}"}
    end
  end
end
