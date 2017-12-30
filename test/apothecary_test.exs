defmodule ApothecaryTest do
  use ExUnit.Case
  doctest Apothecary

  test "greets the world" do
    assert Apothecary.hello() == :world
  end
end
