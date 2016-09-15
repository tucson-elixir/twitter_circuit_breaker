defmodule Web.TwitterChannel do
  use Phoenix.Channel

  def join("twitter:tweets", _message, socket) do
    {:ok, socket}
  end

  def handle_out("new_tweet", payload, socket) do
    push socket, "new_tweet", payload
    {:noreply, socket}
  end
end
