module TheWalters
  # An ArtObject is known in the Walters API as an "Object"
  class ArtObject < Base

    # Get the images for this object
    def images
      # TODO
    end

    private

    def self.api_path; "objects" end
  end
end