module ChitterModule

  module Routes

    class PeepController < Base

      get '/peeps' do
        @peeps = Peep.all(order: [:time.desc])
        erb :'peeps/index'
      end

      post '/peep' do
        current_user.peeps.create(body: params[:peep_body], time: Time.now)
        redirect to('/peeps')
      end

    end

  end

end