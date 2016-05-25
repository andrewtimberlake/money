if Code.ensure_compiled?(Ecto.Type) do
  defmodule Money.Ecto.JsonTypeTest do
    use ExUnit.Case, async: true
    doctest Money.Ecto.JsonType

    alias Money.Ecto.JsonType

    test "type/0" do
      assert JsonType.type == :map
    end

    test "cast/1 Map" do
      assert JsonType.cast(%{amount: 1_000_00, currency: "GBP"}) == {:ok, Money.new(1_000_00, :GBP)}
    end

    test "cast/1 other" do
      assert JsonType.cast([]) == :error
      assert JsonType.cast(100) == :error
    end

    test "load/1 map" do
      assert JsonType.load(%{amount: 1000, currency: "USD"}) == {:ok, Money.new(1000, :USD)}
      assert JsonType.load(%{"amount" => 1000, "currency" => "USD"}) == {:ok, Money.new(1000, :USD)}
    end

    test "dmmp/1 Money" do
      assert JsonType.dump(Money.new(1000, :GBP)) == {:ok, %{amount: 1000, currency: :GBP}}
    end

    test "dump/1 other" do
      assert JsonType.dump([]) == :error
    end
  end
end
