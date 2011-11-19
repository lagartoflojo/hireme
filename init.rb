module HireMe
  class Init < Sinatra::Base

    configure do
      env = ENV['SINATRA_ENV'] || 'development'
    end

    helpers do
      def build_highcharts_array(data)
        array = "["
        data.each_with_index do |datum, i|
          inner_array = "["
          inner_array << "'" + datum[:lang] + "'"
          inner_array << ","
          inner_array << datum[:percentage].to_s
          inner_array << "]"
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
      @username = params[:username]
      @title    = "#{@username}'s Profile"

      stats = [
        {lang: "Ruby", count: 10, percentage: (10.0/21.0)},
        {lang: "PHP", count: 4, percentage: (4.0/21.0)},
        {lang: "Python", count: 7, percentage: (7.0/21.0)}
      ]

      @lang_stats = build_highcharts_array(stats)

      erb :profile
    end

  end
end
