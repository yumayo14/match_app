class UsersController < ApplicationController

  before_action :authenticate_user!

  require 'payjp'
  Payjp.api_key = PAYJP_SECRET_KEY

  def index
  end

  def show
    @exist_user_card == cardcheck
    if @exist_user_card == true
      customer = Payjp::Customer.retrieve(id: current_user.id.to_s)
      @customer_cards = customer.cards.data
    end
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

    @exist_user_card == cardcheck
    if @exist_user_card == true
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
