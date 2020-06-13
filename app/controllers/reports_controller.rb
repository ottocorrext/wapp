class ReportsController < ApplicationController
  def index
  end

  def coupons
    @coupon_names = Coupon.order(name: :asc).pluck(:name)

    coupon_name = params[:name]
    # TODO: move to scope
    @coupon     = Coupon.where(name: coupon_name).includes(order_items: [order: :user]).first
    return unless @coupon

    order_ids      = @coupon.order_items.pluck(:order_id)
    @order_count   = order_ids.count
    @total_revenue = Order.where(id: order_ids).sum(:total)
  end

  def sales
    @from_date = build_date_from_select params[:from_date]
    @to_date   = build_date_from_select params[:to_date]

    # sets defaults if there is any issue with the search dates
    if !@from_date || !@to_date
      @from_date = DateTime.now - 1.month
      @to_date   = DateTime.now
    end

    @order_items =
      OrderItem.where(state: 'sold')
               .preload(:source)
               .includes(order: :user)
               .references(:order)
               .where(orders: { building_at: @from_date..@to_date })
               .group(:source_id)
               .order(:number)
               .page(params[:page])
  end
end
