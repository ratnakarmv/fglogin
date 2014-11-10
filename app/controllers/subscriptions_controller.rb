class SubscriptionsController < ApplicationController

  DAYS = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun']

  def edit
    @subscription = current_customer.subscription
    @lunches = @subscription.lunch
    @lunches = [] unless @lunches
    @dinners = @subscription.dinner
    @dinners = [] unless @dinners
    @tracks = Track.all
    @preferences = Preference.where(subscription: @subscription)
    @days = DAYS
  end

  def update
    subscription = Subscription.find(params[:id])
    redirect_to root_url if subscription.customer != current_customer

    subscription.lunch = params[:lunch]
    subscription.dinner = params[:dinner]
    notes = params[:subscription][:extra_notes]
    lunch_time = params[:subscription][:lunch_time]
    # subscription.lunch_time = lunch_time
    # subscription.extra_notes = notes
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
    redirect_to root_url
  end

  private
    def preference_params
    end

    def subscription_params
      params.require(:subscription).permit(:lunch_time, :dinner_time, :extra_notes)
    end


end
