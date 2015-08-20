module ChitterModule

  module Routes

    class Base < Sinatra::Base

      include AppHelpers

      enable :sessions
      set :session_secret, 'super secret'

      use Rack::MethodOverride
      register Sinatra::Flash
      register Sinatra::Partial
      enable :partial_underscores
      set :partial_template_engine, :erb

      set :views, proc { File.join(root, '../..','views') }
      set :public_folder, proc { File.join(root, '../..', 'public') }

    end

  end

end