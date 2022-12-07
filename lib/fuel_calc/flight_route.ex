defmodule FuelCalc.FlightRoute do
  alias FuelCalc.Activity

  def total_fuel_calc(module_mass, routes) do
    transformed_routes = transform_routes(routes, [])
    IO.inspect(transformed_routes)

    Enum.reduce(transformed_routes, 0, fn route, acc ->
      acc + get_route_fuel(module_mass, route)
    end)
  end

  def transform_routes([head | tail], cumulative) do
    with {:ok, data} <- Activity.new_route_format(head) do
      transform_routes(tail, cumulative ++ [data])
    end
  end

  def transform_routes([], culmative) do
    # IO.inspect(culmative)
    culmative
  end

  def get_route_fuel(mass, route) do
    with {:ok, fuel} <- calc_fuel(mass, route, 0) do
      IO.inspect(fuel)
      fuel
    end
  end

  defp calc_fuel(mass, _route, cumulative) when mass <= 0 do
    {:ok, cumulative}
  end

  defp calc_fuel(mass, route, cumulative) do
    %{data: {_, gravity}, operators: op} = route
    fuel = Float.floor(mass * gravity * op.multiplier + op.substructor)

    cond do
      fuel > 0 -> calc_fuel(fuel, route, cumulative + fuel)
      true -> calc_fuel(0, route, cumulative)
    end
  end
end
