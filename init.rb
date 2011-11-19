module HireMe
  class Init < Sinatra::Base

    configure do
      env = ENV['SINATRA_ENV'] || 'development'
    end

    # mime_type :json, 'application/json'

    # before do
    #   content_type :json
    # end

    # Show a search box
    get '/' do
      #hello
    end


    # Return JSON or HTML representing
    # the Github user
    get '/:username.?:format?' do

    end

  end
end
