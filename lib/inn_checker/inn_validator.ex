defmodule InnChecker.InnValidator do

  @inn_short_length 10
  @inn_long_length  12

  @weights <<3, 7, 2, 4, 10, 3, 5, 9, 4, 6, 8, 0>>

  def asc_to_dec(<<>>), do: <<>>
  def asc_to_dec(<<digit::8, rest :: binary>>) do
    <<digit - ?0, asc_to_dec(rest) :: binary>>
  end

  def dec_to_asc(<<>>), do: <<>>
  def dec_to_asc((<<digit::8, rest :: binary>>)) do
    <<digit + ?0, dec_to_asc(rest) :: binary>>
  end

  def validate(inn) do
    inn = asc_to_dec(inn)
    validate_digits_range(inn) and
    validate_length(inn) and
      case byte_size(inn) do
        10 -> validate_inn_10(inn)
        12 -> validate_inn_12(inn)
      end
  end

  def validate_digits_range(<<>>), do: true
  def validate_digits_range(<<d :: 8, ds :: binary>>) do
    (d >= 0) and (d <= 9) and validate_digits_range(ds)
  end

  def validate_length(inn) when is_list(inn), do: validate_length(List.to_string(inn))
  def validate_length(inn) when is_binary(inn) do
    size = byte_size(inn)
    size === @inn_long_length or size === @inn_short_length
  end

  def validate_inn_10(inn) do
    sum = calc_sum(inn, :binary.part(@weights, 2, 10))
    sum === :binary.at(inn, 9)
  end

  def validate_inn_12(inn) do
    sum11 = calc_sum(:binary.part(inn, 0, 11), :binary.part(@weights, 1, 11))
    sum12 = calc_sum(inn, :binary.part(@weights, 0, 12))
    sum11 === :binary.at(inn, 10) and sum12 === :binary.at(inn, 11)
  end

  defp calc_sum(<<_ :: binary>> = input, <<_ :: binary>> = weights) when byte_size(input) == byte_size(weights) do
    sum(input, weights)
    |> rem(11)
    |> rem(10)
  end

  defp sum(input, weights) when input === <<>> or weights === <<>>, do: 0
  defp sum(<<d :: 8, ds :: binary>>, <<w :: 8, ws :: binary>>) do
    d * w + sum(ds, ws)
  end

end
