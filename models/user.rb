module HireMe
  class User
    def initialize params
      params["lang_stats"] = HireMe::Github.get_user_lang_stats "#{API}/users/#{params['login']}/repos", PAGE

      params.each_key do |key|
        HireMe::User.send :attr_accessor, key.to_sym
        instance_variable_set "@#{key}", params["#{key}"]
      end
    end

    def display_name
      @name || @login
    end

    private

    def method_missing method, *arguments, &block
      HireMe::User.send :attr_accessor, method
    end
  end
end