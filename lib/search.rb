module HireMe
  class Search
    def self.find username
      response = Typhoeus::Request.get "#{API}/users/#{username}"

      if response.code == 404
        nil
      else
        User.new Yajl::Parser.parse(response.body)
      end
    end
  end
end