class AddressesController < ApplicationController
  def edit
    @address = current_customer.address
    @address = Address.new(customer: current_customer) unless @address
  end

  def new
    @address = Address.new(customer: current_customer)
    render 'edit'
  end

  def update
    @address = current_customer.address

    if @address.update(address_params)
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private
    def address_params
      params.require(:address).permit(:first_name, :last_name, :street_address, :suite, :city, :state, :zip, :phone, :email)
    end
end
