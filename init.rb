require 'yajl'

module HireMe

  API = "https://api.github.com"

  class Init < Sinatra::Base

    configure do
      env = ENV['SINATRA_ENV'] || 'development'
    end

    helpers do
      def build_highcharts_array(data)
        array = "["
        data.each_with_index do |datum, i|
          inner_array = "["
          inner_array << '"' + datum[:name] + '"'
          inner_array << ','
          inner_array << datum[:percentage].to_s
          inner_array << ']'
          array << inner_array
          array << "," unless i == data.size-1
        end
        array << "]"
        array
      end # end build_highcharts_array
    end

    # mime_type :json, 'application/json'

    # before do
    #   content_type :json
    # end

    # Show a search box
    get '/' do
      erb :index
    end


    # Return JSON or HTML representing
    # the Github user
    get '/:username.?:format?' do
      @user = HireMe::Search.find params[:username]
      pass if @user.nil?

      @title    = "#{@username}'s Profile"

      @lang_stats = build_highcharts_array @user.lang_stats

      erb :profile
    end

    not_found do
        erb 'This is nowhere to be found.'
    end

  end
end