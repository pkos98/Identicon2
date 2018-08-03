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
    input
      |> hash_input
      |> pick_color
  end

  def hash_input(input) do
      hex = :crypto.hash(:md5, input)
        |> :binary.bin_to_list()
      %Identicon.Image{hex: hex}

  end

  defp pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | rgb: {r, g, b}}
  end

end
