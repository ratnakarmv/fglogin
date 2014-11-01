class CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = current_customer

    @subscription = @customer.subscription
    @preferences = @subscription.preferences
    @lunches = @subscription.lunch
    @dinner = @subscription.dinner
    
    @address = @customer.address

  end
end
