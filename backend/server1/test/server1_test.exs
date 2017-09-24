defmodule Server1Test do
  use ExUnit.Case
  doctest Server1

  test "greets the world" do
    assert Server1.hello() == :world
  end
end
