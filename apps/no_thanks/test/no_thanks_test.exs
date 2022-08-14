defmodule NoThanksTest do
  use ExUnit.Case
  doctest NoThanks

  test "greets the world" do
    assert NoThanks.hello() == :world
  end
end
