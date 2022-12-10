
import FuelCalc
apollo_11 = fn() -> total_fuel_calc(28801,[{:launch,9.807}, {:land, 1.62}, {:launch,1.62}, {:land, 9.807}])end
mission_mars = fn() -> total_fuel_calc(14606,[{:launch, 9.807}, {:land, 3.711}, {:launch, 3.711},{:land, 9.807}]) end
passenger_ship = fn() -> total_fuel_calc(75432,[{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62},{:land, 3.711},{:launch, 3.711}, {:land,9807}])end
