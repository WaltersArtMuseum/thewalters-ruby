module TheWalters
  # Geographies are locations on Earth where museum objects have been created
  # or discovered, or locations that an object depicts or mentions.
  class Geography < Base

    def objects
      # TODO
    end

    private

    def self.api_path; "geographies" end
  end
end
