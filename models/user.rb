module HireMe
  class User
    def initialize params
      params["lang_stats"] = HireMe::Github.get_user_lang_stats "#{API}/users/#{params['login']}/repos", PAGE

      params.each_key do |key|
        set_attribute key
      end
    end

    def display_name
      @name || @login
    end

    private

    def set_attribute key
      HireMe::User.send :attr_accessor, key.to_sym
      instance_variable_set "@#{key}", params["#{key}"]
    end

    def method_missing method, *arguments, &block
      set_attribute method.to_s
    end
  end
end