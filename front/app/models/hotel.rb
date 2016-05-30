require 'rubygems'
require 'httparty'

class Hotel
  include HTTParty
  include ActiveModel::Conversion
  extend  ActiveModel::Naming
  base_uri 'miranda.to:3030'
  headers 'Content-Type' => 'application/json'
  #basic_auth 'username', 'password'
  #default_params :output => 'json'
  format :json

  attr_accessor :id, :name, :address, :star_rating, :accomodation_type
  attr_reader :errors, :searchableText

  def initialize(*args)
    @errors = ActiveModel::Errors.new(self)
    if args.size == 1
      args[0].each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil? || k == "$loki"
      end
    end
  end

  def searchableText
      "#{name} - #{address}"
  end

  def self.all()
    get('/hotels').parsed_response.collect{ |node| Hotel.new(node) }
  end

  def self.find(id)
    r = get("/hotel/#{id}")
    Hotel.new(r.parsed_response)
  end

  def self.find_by_field(field, value)
    r = get('/hotels', :query => {:value => value, :field => field, :op => "$regex"})
    r.parsed_response.collect{ |node| Hotel.new(node) }
  end

  def self.search(value)
    r = get('/hotels', :query => {:value => value})
    r.parsed_response.collect{ |node| Hotel.new(node) }
  end

  def self.find_by_name(name)
    r = get('/hotels', :query => {:value => name, :field => "name", :op => "$regex"})
    r.parsed_response.collect{ |node| Hotel.new(node) }
  end

  def self.find_by_address(address)
    r = get('/hotels', :query => {:value => address, :field => "address", :op => "$regex"})
    r.parsed_response.collect{ |node| Hotel.new(node) }
  end

  def persisted?
    self.id
  end

  def save
    self.class.post('/hotels', :body => self.to_json)
  end

  def update(params)
    r = self.class.post("/hotel/#{id}", :body => params.to_json)
    Hotel.new(r.parsed_response)
  end

  def destroy
    self.class.delete("/hotel/#{id}")
  end

end
