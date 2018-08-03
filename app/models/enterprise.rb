class Enterprise < ApplicationRecord
  validates :name, presence: true
  validates :ruc, presence: true, length: { is: 11 }

  has_many :users
  has_many :rooms
  has_many :locals
  has_many :rooms_types
  has_many :rooms_states

  def get_rooms(rooms_state_id = nil, rooms_type_id = nil)
    if rooms_state_id && rooms_type_id
      rooms.where(rooms_state_id: rooms_state_id, rooms_type_id: rooms_type_id)
    elsif rooms_state_id && !rooms_type_id
      rooms.where(rooms_state_id: rooms_state_id)
    elsif !rooms_state_id && rooms_type_id
      rooms.where(rooms_state_id: rooms_type_id)
    else
      rooms
    end
  end
end
