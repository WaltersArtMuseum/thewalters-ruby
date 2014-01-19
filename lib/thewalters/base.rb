module TheWalters
  # An error accessing the Walters API.
  class ApiError < StandardError; end
  class NotFound < StandardError; end

  def self.apikey=(apikey)
    @apikey = apikey
  end
  def self.apikey
    @apikey
  end

  # A base objet for all endpoints.
  class Base < Hashie::Mash

    # Get a list of all.
    def self.all(params={})
      get_all(params)
    end

    private

    # Returns a Hash; "Items" contains the array of items.
    def self.get_all(params)
      path = [version, api_path].join("/")
      result = fetch(path, params)
      result["Items"] = result["Items"].map {|o| self.new(o) }
      result
    end

    def self.get_by_id(id)
      path = [version, api_path, id].join("/")
      result = fetch(path)
      object = result["Data"]
      self.new(object)
    end

    def self.version; "v1" end
    def self.base_url; "http://api.thewalters.org" end
    def self.path
      raise "Path not defined for this class"
    end

    def self.faraday
      Faraday.new(
        base_url,
        headers: {:user_agent => "walters-ruby (Faraday v#{Faraday::VERSION})", :accept => 'application/json'}
      ) do |faraday|
        # faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end
    end

    def self.fetch(path, params={})
      raise "You must first set your api key: try `TheWalters.apikey = '<mykey>'" if TheWalters.apikey.nil?
      params = {:apikey => TheWalters.apikey}.merge(params)
      response = faraday.get(path, params)
      # puts "body: #{response.body}"
      if response.success?
        if response.headers['content-type'] =~ /json/
          parsed = JSON.parse(response.body)
        else
          raise ApiError.new("Response is not JSON: #{response.body}")
        end
      elsif response.status == 404
        raise NotFound.new("This resource was not found: #{path}")
      else
        if response.headers['content-type'] =~ /json/
          parsed = JSON.parse(response.body)
          # p parsed['ExceptionMessage']
          details = parsed['Message'] || parsed['ReturnMessage']
        else
          details = response.body
        end
        raise ApiError.new("#{response.status}: #{details}")
      end
    end

  end
end
