defmodule FuelCalc.FlightRoute do
  alias FuelCalc.Activity

  # This function get the list of our mission routes steps then transforms it.
  def transform_routes([head | tail], routes_list) do
    with {:ok, data} <- Activity.new_route_format(head) do
      transform_routes(tail, routes_list ++ [data])
    end
  end

  def transform_routes([], routes_list) do
    Enum.sort_by(routes_list, & &1.index, :desc)
  end

  # This function is responsible to get a route and the mass of the equipement
  # and returns the fuel required for the route
  def get_route_fuel(mass, route) do
    with {:ok, fuel} <- calc_fuel(mass, route, 0) do
      fuel
    end
  end

  defp calc_fuel(mass, _route, routes_list) when mass <= 0 do
    {:ok, routes_list}
  end

  defp calc_fuel(mass, route, routes_list) do
    %{data: {_, gravity}, operators: op} = route
    fuel = Float.floor(mass * gravity * op.multiplier + op.substructor)

    cond do
      fuel > 0 -> calc_fuel(fuel, route, routes_list + fuel)
      true -> calc_fuel(0, route, routes_list)
    end
  end
end
