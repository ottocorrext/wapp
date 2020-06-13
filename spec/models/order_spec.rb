require 'rails_helper'

#describe Order, 'Validations' do
describe Order do
  context 'validations' do
    it { is_expected.to validate_presence_of :state }
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :total }
  end

  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:address) }

    it { should have_many(:order_items) }
    it { should have_many(:payments) }
  end

end
