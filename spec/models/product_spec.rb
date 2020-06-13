require 'rails_helper'

describe Product, 'Validations' do

  context 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :sku }
    it { is_expected.to validate_presence_of :msrp }
    it { is_expected.to validate_presence_of :cost }

    it { is_expected.to validate_uniqueness_of(:sku) }

    it { is_expected.to validate_numericality_of(:msrp).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:cost).is_greater_than_or_equal_to(0) }
  end

  context 'associations' do
    it { should have_many(:order_items) }
  end

end
