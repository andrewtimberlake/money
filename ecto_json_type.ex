if Code.ensure_compiled?(Ecto.Type) do
  defmodule Money.Ecto.JsonType do
    @moduledoc """
    Provides a type for Ecto usage.
    The underlying data type should be a map (JSONB in Postgresql)

    This type allows for multiple currency support

    ## Migration Example

        create table(:my_table) do
          add :amount, :jsonb
        end

    ## Schema Example

        schema "my_table" do
          field :amount, Money.Ecto.JsonType
        end
    """

    @behaviour Ecto.Type

    @spec type :: :map
    def type, do: :map

    @spec cast(map) :: {:ok, Money.t}
    def cast(val)
    def cast(%{amount: amount, currency: currency}),
      do: {:ok, Money.new(amount, currency)}
    def cast(_), do: :error

    @spec load(map) :: {:ok, Money.t}
    def load(%{amount: amount, currency: currency}),
      do: {:ok, Money.new(amount, currency)}
    def load(%{"amount" => amount, "currency" => currency}),
      do: {:ok, Money.new(amount, currency)}

    @spec dump(Money.t) :: {:ok, map}
    def dump(%Money{amount: amount, currency: currency}),
      do: {:ok, %{amount: amount, currency: currency}}
    def dump(_), do: :error
  end
end
