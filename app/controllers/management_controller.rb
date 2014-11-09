class ManagementController < ApplicationController
  def subscription
    @query = params[:q]

    if @query
      @customer = Customer.find_by_email(@query)
      if @customer
        @subscription = Subscription.find_by_customer_id(@customer.id)
        if @subscription
          @preferences = @subscription.preferences
          @lunches = @subscription.lunch
          @dinners = @subscription.dinner
          @extra_notes = @subscription.extra_notes
          @upcoming_meal = @subscription.upcoming_meal
        end
      end


    end

  end

  def update_meal
    @subscription = Subscription.find(params[:id])
    if @subscription.update(subscription_params)
      redirect_to management_subscription_url(q: @subscription.customer.email)
    end
  end

  private
    def subscription_params
      params.require(:subscription).permit(:upcoming_meal)
      
    end
end
