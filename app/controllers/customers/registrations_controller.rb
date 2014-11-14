class Customers::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @a = 'balbnalbal'
    @address = Address.new()
    super
    
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    id = resource.id
    @address = Address.new(address_params)
    @address.customer = resource


    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved

      require 'mandrill'
      mandrill = Mandrill::API.new '7RZIKxnlpNkJrGW8sN5Utw'

      if @address.save
        subscription = Subscription.new()
        subscription.customer_id = id
        subscription.save

        message = {"html" =>"<p> Congratulations! <br><br>

          You’ve signed up for a subscription with FoodGem. Expect to have some of the most delicious food from the best restaurants in your area!<br><br>

          Please contact us at info@foodgem.com with any questions you have.<br><br>

          Cheers!</p>",
                    "text"=>"Congratulations! 
          You’ve signed up for a subscription with FoodGem. Expect to have some of the most delicious food from the best restaurants in your area!

          Please contact us at info@foodgem.com with any questions you have.

          Cheers!",
        "subject"=>"Success! You Have Subscribed to FoodGem!",
        "from_email"=> "noreply@foodgem.com",
        "to" => [{"email"=>resource.email,
          }],
        }
        sending = mandrill.messages.send message
        puts sending
      end
      


      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end



    # if resource.save

    # super
    

    
      
      



    # end
  end

  # GET /resource/edit
  # def edit

  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # You can put the params you want to permit in the empty array.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private
    def address_params
      params.require(:address).permit(:phone)
    end
end
