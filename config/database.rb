require 'mongoid'

configure do
	Mongoid.load!("./config/mongoid.yml")
end
