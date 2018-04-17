defmodule Extext.Documents do
  @moduledoc false
  def scan(root) do
    glob = root <> "/**/*.{md,MD,Md}"
    Path.wildcard(glob)
  end

  @doc """
  scan default dirs as configured
  """
  def scan() do
    Application.get_env(:extext, :directories)
    |> Enum.flat_map(&scan/1)
  end

  def read(filepath) do
    case File.exists?(filepath) do
      true -> File.stream!(filepath)
      _ -> "File does not exist: #{IO.inspect filepath}" # {:err, "File does not exist: #{IO.inspect filepath}"}
    end
  end
end
