class Cache

	attr_reader :client

	def initialize
		@client = create_client
	end

	def set_cache(key, value)
		client.set(key, value)
	end

	def get_cache(key, val)
		client.get(key, val)
	end

	private

	def create_client
		Dalli::Client.new(('mc4.c1.eu-central-1.ec2.memcachier.com'|| "").split(","),
					            { :username => "#{SENSITIVE_DATA['cache']['username']}",
					             	:password => "#{SENSITIVE_DATA['cache']['password']}",
												:failover => true,            # default is true
												:socket_timeout => 1.5,       # default is 0.5
												:socket_failure_delay => 0.2, # default is 0.01
												:down_retry_delay => 60       # default is 60
				           	 	})
	end
end
