defmodule ExTestDoc.Options do
  defstruct dir: nil, formatter: nil, doc_level: nil

  @type t :: %__MODULE__{
    dir: nil | String,
    formatter: nil | String.t,
    doc_level: nil | String.t,
  }
end
