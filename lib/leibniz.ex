defmodule Leibniz do
  def eval(expr, vars \\ []) do
    case parse(expr) do
      {:error, e} -> {:error, e}
      # TODO: check deps here to 
      # give better errors
      ast ->
        try do
          match(ast, vars)
        catch
          {:error, e} -> {:error, e}
        end
    end
  end

  def parse(expr) do
    with {:ok, tokens, _} <- expr |> to_charlist() |> :lexer.string(),
         {:ok, ast} <- :parser.parse(tokens) do
         ast 
    else
      {:error, e} -> {:error, e}
    end
  end
 
  defp match(token, vars) when is_number(token), do: token 

  defp match(token, vars) when is_atom(token) do
    case Keyword.get(vars, token) do
      nil -> throw {:error, "#{token} was used but no associated value was found"}
      var -> var
    end
  end

  defp match({:+, lhs, rhs}, vars), do: match(lhs, vars) + match(rhs, vars)
  defp match({:-, lhs, rhs}, vars), do: match(lhs, vars) - match(rhs, vars)
  defp match({:*, lhs, rhs}, vars), do: match(lhs, vars) * match(rhs, vars)
  defp match({:/, lhs, rhs}, vars), do: match(lhs, vars) / match(rhs, vars)


  def dependecies({_, lhs, rhs}) do
    do_dependecies(lhs, []) ++ do_dependecies(rhs, [])
  end
  
  def dependecies(_), do: []

  defp do_dependecies(node, acc) when is_atom(node), do: [node] ++ acc
  defp do_dependecies({_, lhs, rhs}, acc) do
    do_dependecies(lhs, acc) ++ do_dependecies(rhs, acc)
  end
  defp do_dependecies(_, acc), do: acc
end
