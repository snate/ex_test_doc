defmodule ModuleParser do

  alias ExTestDoc.Module, as: Module

  def parse(%Module{name: ""}) do
    IO.puts "Empty file"
  end

  def parse(mod = %Module{name: name}) do
    IO.puts "Starting docs generation for " <> name <> "Test..."
    %{mod | tests: extract_tests mod.lines}
  end

  def extract_tests([]) do
  end

  def extract_tests([line | rem]) do
    cond do
      Regex.match?(start_doc_regex, line) ->
        {test_description, after_doc} = get_test_description(rem)
        [test_decl | after_test] = after_doc
        test_name = String.split(test_decl,"\"")
                    |> Enum.fetch!(1)
        [{test_name, String.slice(test_description, 0..-2)} |
          extract_tests after_test]
      Regex.match?(test_regex, line) ->
        IO.inspect line
        test_name = String.split(line,"\"")
                    |> Enum.fetch!(1)
        [{test_name, ""} | extract_tests rem]
      true           ->
        extract_tests rem
    end
  end

  defp get_test_description([]) do
    {"", []}
  end

  defp get_test_description([line | rem]) do
    cond do
      Regex.match?(end_doc_regex, line) ->
        {"", rem}
      true                              ->
        {docs, new_rem} = get_test_description rem
        {line <> " " <> docs, new_rem}
    end
  end

  defp start_doc_regex do
    Regex.compile!("@doc[ ]\"\"\"")
  end

  defp test_regex do
    Regex.compile!("^test*")
  end

  defp end_doc_regex do
    Regex.compile!("\"\"\"")
  end
end
