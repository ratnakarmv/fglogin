class SubscriptionsController < ApplicationController

  DAYS = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun']

  def edit
    @subscription = current_customer.subscription
    @tracks = Track.all
    @preferences = Preference.where(subscription: @subscription)
    @days = DAYS
  end

  def update
    subscription = current_customer.subscription

    @pref_track_names = params[:preferences]
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
    end


end
