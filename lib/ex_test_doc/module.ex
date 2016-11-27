defmodule ExTestDoc.Module do
  defstruct name: nil, lines: nil

  @type t :: %__MODULE__{
    name: nil | String.t,
    lines: nil | list()
  }
end