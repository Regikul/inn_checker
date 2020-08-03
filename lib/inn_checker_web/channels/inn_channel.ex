defmodule InnCheckerWeb.InnChannel do
  use InnCheckerWeb, :channel


  def join("channel:inn", _params, socket) do
    {:ok, %{inns: []}, socket}
  end

  def handle_in("verify", %{"inn" => inn}, socket) do
    reply = %{
      id: 0,
      status: "valid",
      inn: inn
    }
    broadcast!(socket, "new_inn", reply)
    {:reply, :ok, socket}
  end

  def handle_in(_request, _payload, socket) do
    {:noreply, socket}
  end

end
