require 'payjp'

class UsersController < ApplicationController

  before_action :authenticate_user!
  def index
  end

  def show

    Payjp.api_key = PAYJP_SECRET_KEY
    customer = Payjp::Customer.retrieve(id: current_user.id.to_s)
    @customer_cards = customer.cards.data
   end


  def edit
  end

  def new
  end

  def create
  end

  def update
  end

  def destroy
  end

  def card_registrate
    Payjp.api_key = PAYJP_SECRET_KEY
    if (customer = Payjp::Customer.retrieve(id: current_user.id.to_s))
      customer.card =  params['payjp-token']
      customer.save
    else
      customer = Payjp::Customer.create(
        id: current_user.id,
        email: current_user.email,
        card: params['payjp-token']
      )
    end
  end

  def card_destroy
    Payjp.api_key = PAYJP_SECRET_KEY
    customer = Payjp::Customer.retrieve(params[:customer])
    customer_card = customer.cards.retrieve(params[:id])
    customer_card.delete
    redirect_to user_path(current_user.id)
  end

  private
  # def card_params
  #   params.permit(:number,:cvc, :year, :month, :name)
  # end

end
