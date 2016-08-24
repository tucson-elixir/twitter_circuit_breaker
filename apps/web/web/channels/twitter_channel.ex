defmodule Web.TwitterChannel do
  use Phoenix.Channel

  def join("twitter:tweets", _message, socket) do
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_out("new_tweet", payload, socket) do
    push socket, "new_tweet", payload
    {:noreply, socket}
  end
end
