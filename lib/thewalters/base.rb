module TheWalters
  class ApiError < StandardError; end
  class Base < Hashie::Mash

    def self.all(params={})
      get_all(params)
    end

    def self.find(id)
      get_by_id(id)
    end

    private

    def self.get_all(params)
      path = [version, api_path].join("/")
      objects = fetch(path, params)
      objects.map {|o| self.new(o) }
    end

    def self.get_by_id(id)
      path = [version, api_path, id].join("/")
      object = fetch(path)
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
        headers: {user_agent: "walters-ruby (Faraday v#{Faraday::VERSION})"}
      ) do |faraday|
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end
    end

    def self.fetch(path, params={})
      response = faraday.get(path, params)
      # puts "body: #{response.body}"
      if response.headers['content-type'] =~ /json/
        parsed = JSON.parse(response.body)
        if response.success?
          parsed
        else
          details = ": #{parsed['Message'] || parsed['ReturnMessage']}"
          # p parsed['ExceptionMessage']
          raise ApiError.new("#{response.status}#{details}")
        end
      else
        raise ApiError.new("Response is not JSON: #{response.body}")
      end
    end

  end
end
