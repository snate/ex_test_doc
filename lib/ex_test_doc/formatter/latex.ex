defmodule ExTestDoc.Formatter.Latex do

  def run([], _opts) do
  end

  def run(modules_list, opts) do
    File.mkdir_p output_dir
    for module <- modules_list do
      write_docs_for module
    end
    create_main_file modules_list, opts[:doc_level]
    modules_list
  end

  defp write_docs_for(module) do
    module.name
    |> create_folder_for_module
    |> String.split
    |> Enum.concat(["/",module.name,".tex"])
    |> Enum.join
    |> File.open!([:write])
    |> write_preamble(module.name)
    |> write_tests(module.tests)
  end

  defp create_folder_for_module(name) do
    dir_name = name
               |> String.split(".")
               |> Enum.slice(0..-2)
               |> List.insert_at(0,output_dir <> "/modules")
               |> Enum.join("/")
    File.mkdir_p dir_name
    dir_name
  end

  defp write_preamble(file, name) do
    text = "\\paragraph\{"<>name<>"Test\}\n"
    IO.write file, text
    file
  end

  defp write_tests(file, []) do
    file
  end

  defp write_tests(file, tests) do
    IO.write file, "\n\\begin\{itemize\}"
    for test <- tests do
      write_single_test file, test
    end
    IO.write file, "\n\\end\{itemize\}\n"
    file
  end

  defp write_single_test(file,{name, ""}) do
    IO.write file, "\n  \\item \\textbf\{" <> name <> ":\}"
  end

  defp write_single_test(file,{name, desc}) do
    IO.write file, "\n  \\item \\textbf\{" <> name <> ":\} " <> desc
  end

  defp create_main_file(list,level) do
    output_dir <> "/tests.tex"
    |> File.open!([:write])
    |> write_main_file(list,level)
  end

  defp write_main_file(file, test_list, level) do
    IO.write(file, "\\#{level}\{Tests\}\n")
    for test <- test_list do
      slash_separated =
        String.split(test.name,".")
        |> Enum.slice(0..-2)
        |> List.insert_at(0,"modules")
        |> Enum.join("/")
      IO.write(file, "\\input\{#{slash_separated}/#{test.name}.tex\}\n")
    end
  end

  defp output_dir do
    (Application.get_env :ex_test_doc, :output_docs_folder)
    # TODO: Check if provided path ends with '/'
  end
end
