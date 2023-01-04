# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartItem, type: :model do
  context 'Validations' do
    let(:product) { create :product }

    before { create :cart_item, product_id: product.id, sku: product.master.sku }

    specify { should validate_presence_of(:amount) }

    specify do
      should validate_uniqueness_of(:product_id)
        .scoped_to(:sku_id, :cart_id)
        .with_message('item already exist in cart')
    end
  end

  context 'Associations' do
    specify { should belong_to(:product).required }
    specify { should belong_to(:cart).required }
    specify { should belong_to(:sku).required }
  end
end
