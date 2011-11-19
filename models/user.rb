require 'yajl'

module HireMe
  class User

    def initialize params
      params["lang_stats"] = get_lang_stats "#{API}/users/#{params['login']}/repos", 1

      params.each_key do |key|
        HireMe::User.send :attr_accessor, key.to_sym
        instance_variable_set "@#{key}", params["#{key}"]
      end

    end

    private

    def get_lang_stats url, page
      response = Typhoeus::Request.get url

      repos ||= []
      repos <<  Yajl::Parser.parse(response.body)

      if next_link? response.headers_hash
        url = "#{url.gsub(/\?page.*?$/, '')}?page=#{page.next}"
        get_lang_stats url, page.next
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

    def next_link? headers
        next_link, = headers["Link"].scan('rel="next"') unless headers["Link"].empty?
        return !!next_link
    end
  end
end