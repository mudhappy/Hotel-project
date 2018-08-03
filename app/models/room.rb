class Room < ApplicationRecord
  belongs_to :rooms_type
  belongs_to :rooms_state
  belongs_to :enterprise

  def price
    super.nil? ? self.rooms_type.recommended_price : super
  end
end
