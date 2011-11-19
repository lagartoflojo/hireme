module HireMe
  # Schema:
  # {
  #   user:
  #     {
  #       login:
  #       name:
  #       bio:
  #       avatar_url:
  #       lang_stats:
  #         "#{lang}":
  #     }
  # }

  API = "https://api.github.com"

  class User
    def self.find_by_name username
      response = Typhoeus::Request.get "#{API}/users/#{username}"

      if response.code == 404
        nil
      else
        self.represent Yajl::Parser.parse(response.body)
      end
    end

    private

    def self.represent user
      representation = { user: {} }

      representation[:user][:login]       = user["login"]
      representation[:user][:name]        = user["name"]
      representation[:user][:bio]         = user["bio"]
      representation[:user][:avatar_url] = user["avatar_url"]
      representation[:user][:lang_stats]  = lang_stats "#{API}/users/#{user['login']}/repos", 1

      representation
    end

    def self.lang_stats url, page
      response = Typhoeus::Request.get url

      repos ||= []
      repos <<  Yajl::Parser.parse(response.body)

      if self.next_link? response.headers_hash
        url = "#{url.gsub(/\?page.*?$/, '')}?page=#{page.next}"
        lang_stats url, page.next
      end

      langs = repos.flatten.collect { |repo| repo["language"] }.delete_if { |lang| lang == nil }.sort
      stats = {}

      langs.uniq.each do |lang|
        stats["#{lang}"] = langs.count { |l| l == lang }
      end

      stats
    end

    def self.next_link? headers
      next_link, = headers["Link"].scan('rel="next"')
      !!next_link
    end
  end
end