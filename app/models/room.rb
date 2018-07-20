class Room < ApplicationRecord
  belongs_to :rooms_type
  belongs_to :rooms_states
end
