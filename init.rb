module HireMe
  class Init < Sinatra::Base

    configure do
      env = ENV['SINATRA_ENV'] || 'development'
    end

    mime_type :json, 'application/json'

    before do
      content_type :json
    end

    get '/' do
      #hello
  end

  end
end
