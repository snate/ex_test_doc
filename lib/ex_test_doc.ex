defmodule ExTestDoc do

  alias ExTestDoc.Module, as: ModuleInfo
  alias ExTestDoc.ModuleParser, as: ModuleParser

  def run(opts) do
    generate(opts[:dir])
    |> List.flatten
    |> find_formatter(opts[:formatter]).run(opts)
  end

  defp generate(dir) do
    File.ls!(dir)
    |> (Enum.map &(file_or_folder &1))
    |> (Enum.map &(generate_docs_for &1, dir))
  end

  defp file_or_folder(name) do
    cond do
      Regex.match?(~r/.exs/, name) -> {:file, name}
      true                         -> {:folder, name}
    end
  end

  defp generate_docs_for({:file, file_name}, dir) do
    content = File.read! full_path(dir, file_name)
    content
           |> String.split("\n")
           |> (Enum.map &(String.trim &1))
           |> get_module_name
           |> ModuleParser.parse
  end

  defp generate_docs_for({:folder, folder_name}, dir) do
    generate(full_path(dir, folder_name))
  end

  defp full_path(dir, file) do
    dir <> "/" <> file
  end

  defp get_module_name([]) do
    %ModuleInfo{name: "", lines: ""}
  end

  defp get_module_name(file = [fst | rem]) do
    cond do
      Regex.match?(mod_regex, fst) ->
        name =
          String.split(fst, " ")
          |> Enum.fetch!(1)
          |> String.trim
          |> String.slice(0..-5)
        %ModuleInfo{name: name, lines: file}
      true                ->
        get_module_name rem
    end
  end

  defp find_formatter(name) when is_atom(name) do
    [ExTestDoc.Formatter, String.capitalize(Atom.to_string(name))]
    |> Module.concat()
  end

  defp find_formatter(name) do
    [ExTestDoc.Formatter, String.capitalize(name)]
    |> Module.concat()
  end

  defp mod_regex do
    Regex.compile!("[ ]*defmodule*")
  end
end
