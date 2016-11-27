defmodule ModuleParser do

  alias ExTestDoc.Module, as: Module

  def parse(%Module{name: ""}) do
    IO.puts "Empty file"
  end

  def parse(mod = %Module{name: name}) do
    IO.puts "Starting docs generation for " <> name <> "..."
    extract_tests mod.lines
    #parse %Module{name: mod, lines: rem}
  end

  def extract_tests([]) do
    IO.puts ">>>EOF"
  end

  def extract_tests([line | rem]) do
    IO.inspect line
    extract_tests rem
  end

  # TODO list:
  # - when it finds a @doc""", start writing docs for test
  # - when it finds a 'test', take the subsequent string
end
