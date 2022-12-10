defmodule FuelCalc do
  alias FuelCalc.FlightRoute

  def total_fuel_calc(module_mass, routes) do
    transformed_routes = FlightRoute.transform_routes(Enum.with_index(routes), [])

    total_fuel =
      Enum.reduce(transformed_routes, 0, fn route, acc ->
        acc + FlightRoute.get_route_fuel(module_mass + acc, route)
      end)

    IO.puts("The total fuel required for this mission is : #{total_fuel}")
  end
end
