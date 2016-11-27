defmodule ExTestDocTest do
  use ExUnit.Case
  doctest ExTestDoc

  test "the truth" do
    assert 1 + 1 == 2
  end
end
