defmodule Identicon do
  require Integer
  @moduledoc """
  Generates an identicon from a given string
  """

  def main(input) do
    input
    |> hash_input()
    |> pick_color()
    |> build_grid()
    |> filter_odd_squares()
    |> build_pixel_map()
    |> draw_image()
    |> save_image(input)
  end

  def hash_input(input) do
      hex = :crypto.hash(:md5, input)
        |> :binary.bin_to_list()
      %Identicon.Image{hex: hex}
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | rgb: {r, g, b}}
  end

  def build_grid(img) do
    grid = img.hex
    |> Enum.chunk_every(3)
    |> Enum.map(fn x -> mirror_row(x) end)
    |> List.flatten()
    |> Enum.with_index()
    %Identicon.Image{img | grid: grid}
  end

  def mirror_row([a, b, c]), do: [a, b, c, b, a]
  def mirror_row([a]), do: [a]

  def filter_odd_squares(%Identicon.Image{grid: grid} = img) do
    grid = grid |> Enum.filter(fn x ->
      Integer.is_even(elem(x, 0)) end)
    %Identicon.Image{img | grid: grid}
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = img) do
    pixel_map = Enum.map(grid, fn {_x, index} ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50
      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50,  vertical + 50}

      {top_left, bottom_right}
    end)
    %Identicon.Image{img | pixel_map: pixel_map}
  end

  def draw_image(%Identicon.Image{rgb: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn {start, stop} ->
      :egd.filledRectangle(image, start, stop, fill)
    end)
    :egd.render(image)
  end

  def save_image(img, filename) do
    File.write("#{filename}.png", img)
  end

end
