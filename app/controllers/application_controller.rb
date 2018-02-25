class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  require 'payjp'
  Payjp.api_key = PAYJP_SECRET_KEY

  def cardcheck
    @payjpusers = Payjp::Customer.all
    @payjpusers.each do |payjpuser|
      if payjpuser.id.to_i == current_user.id
        @exist_user_card = true
        break
      else
        @exist_user_card = false
      end
    end
    return @exist_user_card
  end

end
