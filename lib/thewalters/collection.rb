module TheWalters
  # A collection is a group of artworks, artifacts, or similar items within
  # the Walters Art Museum. Collections at the Walters are grouped by
  # primarily by culture and sometimes by date.
  class Collection < Base

    def objects
      # TODO
    end

    private

    def self.api_path; "collections" end
  end
end
