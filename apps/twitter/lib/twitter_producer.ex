alias Experimental.GenStage

defmodule Twitter.Producer do
	use GenStage

	def start_link(query) do
		GenStage.start_link(__MODULE__, query, name: __MODULE__)
	end

	def init(query) do
		stream = twitter_stream(query)
		{:producer, stream}
	end

	def handle_demand(demand, stream) when demand > 0 do
		events = stream |> Enum.take(demand)
		{:noreply, events, stream}
	end

	defp twitter_stream(query) do
		ExTwitter.stream_filter([track: query], :infinity)
	end
end
