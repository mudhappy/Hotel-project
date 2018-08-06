class Product < ApplicationRecord
  belongs_to :enterprise
  has_and_belongs_to_many :rooms

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  def decrease_product_amount
    self.quantity -= 1
    save if valid?
  end
end
