defmodule CQEx.Client do
  import CQEx.Helpers
  import CQEx, only: :macros

  defdelegate new,             to: :cqerl, as: :get_client
  defdelegate new(a),          to: :cqerl, as: :get_client
  defdelegate new(a, b),       to: :cqerl, as: :get_client

  def close(client) do
    client
    |> CQEx.Client.get()
    |> :cqerl.close_client()
  end

  @spec new! :: :cqerl.client()
  def new!() do
    case new() do
      {:ok, client} ->
        client
    end
  end

  @spec new!(:cqerl.inet()) :: :cqerl.client()
  def new!(a) do
    case new(a) do
      {:ok, client} ->
        client
    end
  end

  @spec new!(:cqerl.inet(), Keyword.t()) :: :cqerl.client()
  def new!(a, b) do
    case new(a, b) do
      {:ok, client} ->
        client
    end
  end

  def get(client={p, r}) when is_pid(p) and is_reference(r) do
    client
  end
  def get(%CQEx.Result{record: cql_result(client: client)}) do
    client
  end
  def get(cql_result(client: client)) do
    client
  end
  def get(%CQEx.Result.SchemaChanged{client: client}) do
    client
  end
  def get(%CQEx.Result.Empty{client: client}) do
    client
  end
  def get(_) do
    nil
  end
end
