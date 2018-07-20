class Enterprise < ApplicationRecord
	validates :name, presence: true
	validates :ruc, presence: true, length:{ is: 11 }

	belongs_to :user
end
