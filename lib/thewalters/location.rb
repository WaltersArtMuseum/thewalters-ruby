module TheWalters
  # Locations are locations within the Walters Art Museum where the various
  # museum objects are on view. If an object is not on view, it will be
  # associated with a 'not on view' location.
  class Location < Base

    def objects
      # TODO
    end

    private

    def self.api_path; "museum/locations" end
  end
end
