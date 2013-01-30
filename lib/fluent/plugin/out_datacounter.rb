class Fluent::DataCounterOutput < Fluent::BufferedOutput
	Fluent::Plugin.register_output('datacounter', self)

	def initialize
		super
		require 'net/http'
	end

	def configure(conf)
		super
	end

	def start
		super
	end

	def shutdown
		super
	end

	def emit(tag, es, chain)
		chain.next
		es.each {|time, record|
			res = post(tag, time, record)
			$log.warn "time=#{time} record=#{record} body=#{res.body}"
		}
	end

	def post(tag, time, record)
		url = URI.parse("http://douzen.net")
		params = {
			"message" => record
		}
		begin
			#res = Net::HTTP.get(url, params)
			res = Net::HTTP.start(url.host, url.port) { |http|
				http.get('/')
			}
		rescue

		end
		return res
	end
end
