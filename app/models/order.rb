class Order < ApplicationRecord
  BUILDING = "building"
  ARRIVED = "arrived"
  CANCELED = "canceled"
  STATES = [BUILDING, ARRIVED, CANCELED].freeze

  validates_presence_of :user_id, :state

  validates   :total,
              presence: true,
              format: {
                with: /\A-?\d+\.?\d{0,2}\z/,
                message: 'only accepts 2 decimal places.'
              }

  belongs_to :user
  belongs_to :address

  has_many :order_items
  has_many :payments

  scope :user_includes, -> do
    includes(:user).order(:number)
  end

  scope :number_search, ->(number) do
    where(number: number)
      .includes(:user, :address, order_items: :source)
      .first
  end

  scope :field_search, ->(search_field, search_term) do
    where("#{search_field} LIKE ?", "%#{search_term}%").user_includes
  end

  scope :email_search, ->(search_term) do
    # TODO: why do like queries not work in standard include references?
    sql_fragment = ActiveRecord::Base
                   .sanitize_sql_for_conditions(['users.email like ?', "%#{search_term}%"])
    joins("LEFT OUTER JOIN users ON orders.user_id = users.id WHERE #{sql_fragment}").user_includes
  end

  paginates_per 10

  def to_param
    number
  end

  def canceled?
    state == 'canceled'
  end

  def cancel
    return if canceled?

    # TODO: Inform the user the cancel failed
    ActiveRecord::Base.transaction do
      dt = DateTime.now
      update!(state: 'canceled', canceled_at: dt, total: 0)
      order_items.update_all(state: 'returned')
      payments.update_all(state: 'refunded', refunded_at: dt)
    end
  rescue ActiveRecord::RecordInvalid
    logger.error("Invalid Record " + e.message)
    logger.error(e.backtrace)
  end

end
