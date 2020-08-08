defmodule InnCheckerWeb.InnChannel do
  use InnCheckerWeb, :channel

  alias Ecto.Changeset

  alias InnChecker.UserContent
  alias InnChecker.UserContent.Inn

  def join("channel:inn", %{"last_inn_id" => since}, socket) do
    inns = Enum.map(UserContent.list_inns(since), &schema_to_json/1)
    {:ok, %{inns: inns}, socket}
  end

  def handle_in("verify", %{"inn" => inn}, socket) do
    case UserContent.create_inn(%{value: inn}) do
      {:ok, %Inn{} = created} ->
        broadcast!(socket, "new_inn", schema_to_json(created))
        {:reply, :ok, socket}
      {:error, %Changeset{} = changeset} ->
        [{_, {reason, []}} | _] = changeset.errors
        reply = %{
          reason: reason
        }
        {:reply, {:error, reply}, socket}
    end

  end

  def handle_in(_request, _payload, socket) do
    {:noreply, socket}
  end

  defp schema_to_json(%Inn{} = inn) do
    %{
      id: inn.id,
      inn: inn.value,
      status: if inn.valid do "корректен" else "некоректен" end,
      updated_at: inn.updated_at
    }
  end

end
