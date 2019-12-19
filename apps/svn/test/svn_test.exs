defmodule SvnTest do
  use ExUnit.Case
  doctest Svn

  test "greets the world" do
    assert Svn.hello() == :world
  end
end
