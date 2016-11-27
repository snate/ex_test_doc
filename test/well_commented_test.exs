defmodule WellCommentedTest do
  use ExUnit.Case

  @doc """
  Hello world
  """
  test "the truth" do
    assert 1 + 1 == 2
  end

  @doc """
  Bob is quiet
  """
  test "should perform another sum" do
    assert 3 + 1 == 4
  end
end
