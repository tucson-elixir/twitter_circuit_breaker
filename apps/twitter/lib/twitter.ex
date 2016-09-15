defmodule Web.Twitter do
  use GenServer

  def start_link do
    IO.puts("start_link")
    GenServer.start_link(__MODULE__, %{}, [name: Twitter])
  end

  def init(state) do
    tweets = ExTwitter.stream_filter(track: "😀") |> Stream.map(fn(x) ->
        Web.Endpoint.broadcast("twitter:tweets", "new_tweet", %{"body" => x.text})
    end)
    Enum.to_list(tweets)
    {:ok, tweets}
  end
end
