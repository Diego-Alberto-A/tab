defmodule Tablature do
  def parse(tab) do
    tab
    # separamos el texto en lineas
    |> String.split("\n", trim: true)

    |> Enum.map(fn line ->
      # dividimos cada linea
      [string, notes, _] = String.split(line, "|")

      # separamos las notas
      String.graphemes(notes)

      |> Enum.map(fn c ->
        # checamos si es de 0-9
        if c =~ ~r/\d/ do
          # juntamos cuerda + nota
          "#{string}#{c}"
        else
          # si no es numero, dejamos vacio
          ""
        end
      end)
    end)

    # acomodamos las notas por columnas
    |> Enum.zip()

    |> Enum.map(fn tuple ->
      tuple
      |> Tuple.to_list()
      |> Enum.join(" ")
    end)

    |> Enum.join(" ")

    # quitamos espacios extra
    |> String.split()
    |> Enum.join(" ")
  end
end
