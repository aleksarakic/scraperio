class ScrapeResult
	include Mongoid::Document

  field :temperature, type: Integer
  field :city, type: String
  field :time, type: String
  field :note, type: String
end