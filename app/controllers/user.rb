module ChitterModule

  module Routes

    class UserController < Base

      PERMITTED_PARAMS = [:email, :name, :user_name, :password, :password_confirmation]

      get '/users/new' do
        erb :'users/new'
      end

      post '/users' do
        @user = create_user(params)
        if @user.save
          session[:user_id] = @user.id
          redirect to('/peeps')
        else
          flash.now[:errors] = @user.errors.full_messages
          erb :'users/new'
        end
      end

      get '/users/sign-in' do
        erb :'users/sign_in'
      end

      post '/users/sign-in' do
        user = User.authenticate(permitted_params(params))
        if user
          session[:user_id] = user.id
          redirect to('/peeps')
        else
          flash.now[:errors] = ['The username or password is incorrect']
        end
      end

      delete '/user-signout' do
        session.clear
        redirect to('/peeps')
      end

      def create_user(params)
        User.new(permitted_params(params))
      end

      def permitted_params(parameters)
        parameters.map{|key,value|[key.to_sym, value] if PERMITTED_PARAMS.include?(key.to_sym)}.to_h
      end


    end

  end

end