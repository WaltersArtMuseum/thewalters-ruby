module TheWalters
  # Locations are locations within the Walters Art Museum where the various
  # museum objects are on view. If an object is not on view, it will be
  # associated with a 'not on view' location.
  class Location < Base

    def objects(params)
      TheWalters::Location.get_objects(self.LocationID, params)
    end

    private

    def self.api_path; "museum/locations" end
  end
end
