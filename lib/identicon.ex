defmodule Identicon do
  @moduledoc """
  Generates an identicon from a given string
  """

  # Read string
  # Convert string into hash
  # Split hash into chunks (5x5?)
  # determine general color
  # determine if each chunks is colored or not
  # merge chunks
  # save as image

  def main(input) do
    d = input
      |> hash_input()
      |> pick_color()
      |> build_grid()
  end

  def hash_input(input) do
      hex = :crypto.hash(:md5, input)
        |> :binary.bin_to_list()
      %Identicon.Image{hex: hex}
  end

  defp pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | rgb: {r, g, b}}
  end

  defp build_grid(img) do
    grid = img.hex
    |> Enum.chunk_every(3)
    |> Enum.map(fn x -> mirror_row(x) end)
    |> List.flatten()
    |> Enum.with_index()
    %Identicon.Image{img | grid: grid}
  end

  def mirror_row([a, b, c]), do: [a, b, c, b, a]
  def mirror_row([a]), do: [a]
    %Identicon.Image{img | grid: grid}
  end

  defp mirror_row([a, b, c]), do: [a, b, c, b, a]

end
