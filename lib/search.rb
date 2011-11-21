module HireMe
  class Search
    def self.find username
      response = HireMe::Github.get_user_profile username

      return nil if response.code == 404
      HireMe::User.new Yajl::Parser.parse(response.body)
    end
  end
end