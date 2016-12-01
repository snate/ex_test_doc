# ExTestDoc

This tool helps you generate documentation for your Elixir tests.

## Installation

In order to use this package, you should:

  1. Add `ex_test_doc` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ex_test_doc, git: "https://github.com/snate/ex_test_doc.git"}]
    end
    ```

  2. Call `mix testDocs` from the root of your Elixir project. You can specify
      the following options:

    * `--formatter` - select the formatter for your output files. Currently
        only *latex* formatter is available
    * `--directory` - specify the path to your test folder for your Elixir
        project. It is set to *test* by default
    * `--doc-level` - this is the depth that the generated docs is intended to
        be included in a main document (e.g. a subsection in a LaTeX document)
