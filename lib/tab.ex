defmodule Tablature do
  def parse(tab) do
    tab
    # separamos el texto en lineas
    |> String.split("\n", trim: true)

    |> Enum.map(fn line ->
      # dividimos cada linea
      [string | parts] = String.split(line, "|")

      # quitamos compases vacios
      parts = Enum.reject(parts, fn x -> x == "" end)

      # recorremos cada compas
      Enum.map(parts, fn notes ->

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
    end)

    # acomodamos los compases
    |> Enum.zip()

    |> Enum.flat_map(fn measure ->
      measure
      |> Tuple.to_list()

      # acomodamos las notas por columnas
      |> Enum.zip()

      |> Enum.map(fn tuple ->
        tuple
        |> Tuple.to_list()

        # unimos notas simultaneas con /
        |> Enum.filter(fn x -> x != "" end)
        |> Enum.join("/")
      end)

      # detectamos silencios largos
      |> Enum.chunk_by(fn x -> x == "" end)

      |> Enum.flat_map(fn group ->
        if hd(group) == "" and length(group) >= 3 do
          ["_"]
        else
          Enum.reject(group, fn x -> x == "" end)
        end
      end)
    end)

    |> Enum.join(" ")
  end
end
