alias Experimental.GenStage

defmodule Twitter.Consumer do
	use GenStage

	def start_link do
		GenStage.start_link(__MODULE__, [])
	end

	def init(tweets) do
		{:consumer, tweets, subscribe_to: [{Twitter.Producer, min_demand: 5, max_demand: 10}]}
	end

	def handle_events(tweets, _from, stream) do
		new_tweets = tweets |> Enum.map(fn e -> e.text end)
		new_tweets |> Enum.each(fn t -> Web.Endpoint.broadcast("twitter:tweets", "new_tweet", %{"body" => t}) end)

		{:noreply, [], stream}
	end

end
