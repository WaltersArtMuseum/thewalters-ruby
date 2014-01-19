require 'uri'
module TheWalters
  # The URLs for images are able to accept a number of parameters.
  # See https://github.com/WaltersArtMuseum/walters-api/blob/master/images.md
  # and https://github.com/JimBobSquarePants/ImageProcessor
  class Image < Hashie::Mash

    def url(params={})
      escaped_params_as_string = params.to_a.map {|n,v| "#{URI.escape(n.to_s)}=#{URI.escape(v.to_s)}" }.join("&") if params.any?
      [self.ImageURL, escaped_params_as_string].compact.join('?')
    end

    def to_s
      self.url
    end

  end
end
