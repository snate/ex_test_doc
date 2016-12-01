defmodule Mix.Tasks.TestDocs do
  use Mix.Task

  def run(args) do
    Mix.Task.run "compile"
    {cli_opts, _, _} = OptionParser.parse(args,
          aliases: [f: :formatter, d: :dir],
          switches: [formatter: :keep, directory: :string])
    cli_opts
    |> put_formatter_if_not_specified
    |> put_dir_if_not_specified
    |> generate
    Mix.shell.info [:green, "Docs for tests successfully generated"]
  end

  defp put_formatter_if_not_specified(opts) do
    form = opts[:formatter]
    if form != nil do
      opts
    else
      put_in opts[:formatter], :latex
      put_in opts[:formatter], "latex"
    end
  end

  defp put_dir_if_not_specified(opts) do
    form = opts[:directory]
    if form != nil do
      opts
    else
      put_in opts[:dir], "test"
    end
  end

  defp generate(opts) do
    ExTestDoc.run opts
  end
end
