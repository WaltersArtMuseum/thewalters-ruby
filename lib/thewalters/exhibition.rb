module TheWalters
  # An exhibition is an organized presentation and display of a selection
  # of museum objects.
  class Exhibition < Base

    def objects
      # TODO
    end

    private

    def self.api_path; "exhibitions" end
  end
end
