module TheWalters
  # An exhibition is an organized presentation and display of a selection
  # of museum objects.
  class Exhibition < Base

    def objects(params)
      TheWalters::Exhibition.get_objects(self.ExhibitionID, params)
    end

    private

    def self.api_path; "exhibitions" end
  end
end
