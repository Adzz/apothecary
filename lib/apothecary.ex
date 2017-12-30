defmodule Apothecary do
  @moduledoc """
  Apothecary is a library containing all kinds of helpers for generating random
  data. These are particularly useful for property based tests.
  """

  @doc "Generates a possibly negative integer bound by the generation size"
  def possibly_negative_integer do
    StreamData.integer()
  end

  @doc "Generates a possibly negative float from 0..max_float. max_float defaults to 100"
  def possibly_negative_float(max_float_size \\ 100) do
    StreamData.bind(StreamData.boolean(), fn negative? ->
      if negative? do
        StreamData.map(StreamData.uniform_float(), &(-(&1 * max_float_size)))
      else
        StreamData.map(StreamData.uniform_float(), &(&1 * max_float_size))
      end
    end)
  end

  @doc """
  Generates a possibly negative number. The number will be a float around half the time and an integer
  around half the time. The float's size is between 0..max_float_size which defaults to 100. The
  integers size is bound by the default generation size.
  """
  def numeric_string(max_float_size \\ 100) do
    StreamData.frequency([
      {5, NumericGenerators.possibly_negative_integer |> StreamData.map(&Integer.to_string(&1))},
      {5, NumericGenerators.possibly_negative_float(max_float_size) |> StreamData.map(&Float.to_string(&1))},
    ])
  end

  @doc "Generates a string that will not contain numbers"
  def non_numeric_string() do
    StreamData.map(StreamData.binary(), fn (string) ->
      String.replace(string, ~r/\d/, "")
    end)
  end

  @doc """
  Returns a generator for a list that can gen either a list of binarys, list of bitstrings,
  list of possibly negative integers, a list of possibly negative floats, a list of iodata, a list of
  iolists.
  """
  def possibly_empty_list_of_any_non_collection() do
    StreamData.bind(StreamData.integer(0..5), fn random_number ->
      case random_number do
        0 -> StreamData.list_of(StreamData.binary())
        1 -> StreamData.list_of(NumericGenerators.possibly_negative_float())
        2 -> StreamData.list_of(StreamData.bitstring())
        3 -> StreamData.list_of(NumericGenerators.possibly_negative_integer)
        4 -> StreamData.list_of(StreamData.iodata)
        _ -> StreamData.list_of(StreamData.iolist)
      end
    end)
  end
end

