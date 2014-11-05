class CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = current_customer

    @subscription = @customer.subscription
    @subscription = Subscription.create(customer: @customer) unless @subscription
    if @subscription
      @preferences = @subscription.preferences
      @lunches = @subscription.lunch
      @dinners = @subscription.dinner
    end
    
    @address = @customer.address
    @phone = @address.phone


  end
end
