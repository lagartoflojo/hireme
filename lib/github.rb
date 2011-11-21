require 'yajl'

module HireMe
  API  = "https://api.github.com"
  PAGE = 1

  class Github
    def self.get_user_profile username
      Typhoeus::Request.get "#{API}/users/#{username}"
    end

    def get_user_lang_stats url, page
      response = Typhoeus::Request.get url

      repos ||= []
      repos <<  Yajl::Parser.parse(response.body)

      if self.next_link? response.headers_hash
        get_user_lang_stats "#{url.gsub(/\?page.*?$/, '')}?page=#{page.next}", page.next
      end

      langs = repos.flatten.collect { |repo| repo["language"] }.delete_if { |lang| lang == nil }.sort
      stats = []

      langs.uniq.each do |lang|
        count      = langs.count { |l| l == lang }
        percentage = ( count/( langs.count ).to_f ).round 4

        stats << { name: lang, count: count, percentage: percentage }
      end

      stats
    end

    private

    def self.next_link? headers
      next_link, = headers["Link"].scan('rel="next"') unless headers["Link"].empty?
      return !!next_link
    end
  end
end