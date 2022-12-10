defmodule FuelCalcTest do
  alias FuelCalc.Activity
  use ExUnit.Case
  import FuelCalc.Activity
  doctest FuelCalc

  test "greets the world" do
    assert FuelCalc.hello() == :world
  end

  test "transform a step into usable route" do
    assert Activity.new_route_format({{:land, 3.711}, 1}) ==
             {:ok,
              %{
                data: {:land, 3.711},
                index: 1,
                operators: %{multiplier: 0.033, substructor: -42}
              }}
  end

  test "A step with bad arguments" do
    assert Activity.new_route_format({{:step, 3.711}, 1}) ==
             {:error, %{message: "arguments were not rights", data: nil}}
  end
end
