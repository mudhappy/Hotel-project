class Room < ApplicationRecord
  belongs_to :rooms_type
  belongs_to :rooms_state
  belongs_to :enterprise
  has_and_belongs_to_many :products

  def price
    super.nil? ? rooms_type.recommended_price : super
  end

  def add_product(product)
    products << product if product.decrease_product_amount
  end
end
