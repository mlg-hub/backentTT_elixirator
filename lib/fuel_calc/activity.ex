defmodule FuelCalc.Activity do
  def new_route_format({land_or_launch, gravity})
      when is_atom(land_or_launch) and
             is_number(gravity) do
    case Enum.member?([:land, :launch], land_or_launch) do
      true ->
        operators = get_activity_operators(land_or_launch)
        {:ok, %{data: {land_or_launch, gravity}, operators: operators}}

      _ ->
        new_route_format({"", ""})
    end
  end

  def new_route_format({_land_or_laung, _gravity}) do
    {:error, %{message: "arguments were not rights", data: nil}}
  end

  def get_activity_operators(land_or_launch) do
    cond do
      land_or_launch == :launch -> %{multiplier: 0.042, substructor: -33}
      true -> %{multiplier: 0.033, substructor: -42}
    end
  end
end
