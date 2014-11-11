class ManagementController < ApplicationController
  before_action :authenticate_admin_user!

  DAYS = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun']
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
          @lunch_time = @subscription.lunch_time ? @subscription.lunch_time.strftime('%H,%M') : "default time" 
          @dinner_time = @subscription.dinner_time ? @subscription.dinner_time.strftime('%H,%M') : "default time" 
        end
      end


    end

  end

  def update_meal
    @subscription = Subscription.find(params[:id])
    if @subscription.update(meal_params)
      redirect_to management_subscription_url(q: @subscription.customer.email)
    end
  end

  def edit_subscription
    @subscription = Subscription.find(params[:id])
    @lunches = @subscription.lunch
    @lunches = [] unless @lunches
    
    @dinners = @subscription.dinner
    @dinners = [] unless @dinners
    
    @tracks = Track.all
    @preferences = Preference.where(subscription: @subscription)
    @days = DAYS
  end

  def edit_customer
    @customer = Customer.find(params[:id])
  end

  def update_customer
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to management_subscription_url(q: @customer.email)
    else
      render 'edit_customer'
    end
  end

  def update_subscription
    subscription = Subscription.find(params[:id])

    subscription.lunch = params[:lunch]
    subscription.dinner = params[:dinner]
    notes = params[:subscription][:extra_notes]
    lunch_time = params[:subscription][:lunch_time]
    subscription.save

    subscription.update(subscription_params)
    
    @pref_track_names = params[:preferences] ? params[:preferences] : []
    @old_preferences = Preference.where(subscription: subscription)
    @deleted_preferences = Preference.none

    @olds_after_delete = @old_preferences.reject{|old| @pref_track_names.include?(old.track.name) == false}
    @old_preferences.each do |oldie|
      unless @pref_track_names.include?(oldie.track.name)
        oldie.destroy
      end
    end

    @pref_track_names.each do |name|    
      track = Track.find_by_name(name)
      Preference.create(subscription: subscription, track: track) unless @old_preferences.where(track: track).any?
    end
    redirect_to management_subscription_url(q: subscription.customer.email)
  end

  private

    def subscription_params
      params.require(:subscription).permit(:lunch_time, :dinner_time, :extra_notes)
    end
    def meal_params
      params.require(:subscription).permit(:upcoming_meal)
      
    end

    def customer_params
      params.require(:customer).permit(:password, :password_confirmation)
    end
end
