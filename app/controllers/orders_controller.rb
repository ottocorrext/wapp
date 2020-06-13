class OrdersController < ApplicationController
  before_action :find_order!, only: [:show, :cancel]

  def index
    fields = {
      'Order Number' => 'number',
      'Email' => 'email',
      'State' => 'state'
    }
    @search_fields = fields.keys

    search_field = fields[params[:search_field]]
    search_term  = params[:search_term]

    if search_field && search_term
      @orders = search_orders(search_field, search_term).page(params[:page])
    else
      @orders = Order.includes(:user).order(:number).page(params[:page])
    end
  end

  def show
  end

  def cancel
    @order.cancel
    redirect_to @order, notice: 'Order was cancelled'
  end

  private

  def search_orders(search_field, search_term)
    case search_field
    when 'number', 'state'
      Order.field_search(search_field, search_term)
    when 'email'
      Order.email_search(search_term)
    end
  end

  def find_order!
    @order = Order.number_search(params[:number])
  end
end
