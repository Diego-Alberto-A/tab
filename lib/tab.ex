defmodule Tablature do
  def parse(tab) do
    tab
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [string, notes, _] = String.split(line, "|")

      String.graphemes(notes)
      |> Enum.map(fn c ->
        if c =~ ~r/\d/ do
          "#{string}#{c}"
        else
          ""
        end
      end)
    end)
    |> Enum.zip()
    |> Enum.map(fn tuple ->
      tuple
      |> Tuple.to_list()
      |> Enum.join(" ")
    end)
    |> Enum.join(" ")
    |> String.split()
    |> Enum.join(" ")
  end
end
