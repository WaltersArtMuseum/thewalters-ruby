module TheWalters
  # An ArtObject is a piece of art, an artifact or similar item within the
  # Walters collections. It's known in the Walters API as an "Object".
  class ArtObject < Base

    # Find a specific Object by id.
    def self.find(id)
      get_by_id(id)
    end

    # Get the images for this object
    def images
      TheWalters::ArtObject.get_images(self.ObjectID)
    end

    private

    def self.api_path; "objects" end
  end
end
