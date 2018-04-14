defmodule Extext.Documents do
  @moduledoc false
  def scan(root) do
    glob = root <> "/**/*.md"
    Path.wildcard(glob)
#    |> Path.split
  end

  def scan() do
    Application.get_env(:extext, :directories)
    |> Enum.map(&scan/1)
  end

  def read(filepath) when is_bitstring(filepath) do
    case File.exists?(filepath) do
      true -> {:ok, File.stream!(filepath)}
      _ -> {:err, "File does not exist"}
    end
  end

  def read(filepath) when is_list(filepath), do: Path.join(filepath) |> read
#    Path.join(filepath)
#    |> read
#  end
end
