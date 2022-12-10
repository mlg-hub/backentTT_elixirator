defmodule FuelCalc.Activity do
  #  This function takes a mission's step with its index (the order of the step)
  #  and transforms it to a route that is helpful to work with

  def new_route_format({{land_or_launch, gravity}, index})
      when is_atom(land_or_launch) and
             is_number(gravity) do
    case Enum.member?([:land, :launch], land_or_launch) do
      true ->
        operators = get_activity_operators(land_or_launch)
        {:ok, %{data: {land_or_launch, gravity}, operators: operators, index: index}}

      _ ->
        new_route_format({{"", ""}, 0})
    end
  end

  def new_route_format({{_land_or_laung, _gravity}, _}) do
    {:error, %{message: "arguments were not rights", data: nil}}
  end

  # This function takes the step operation land or launch and apply to it respective formulas
  # as given in the exercise
  def get_activity_operators(land_or_launch) do
    cond do
      land_or_launch == :launch -> %{multiplier: 0.042, substructor: -33}
      true -> %{multiplier: 0.033, substructor: -42}
    end
  end
end
