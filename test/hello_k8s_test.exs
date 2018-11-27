defmodule HelloK8sTest do
  use ExUnit.Case
  doctest HelloK8s

  test "greets the world" do
    assert HelloK8s.hello() == :world
  end
end
