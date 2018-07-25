class Enterprise < ApplicationRecord
	validates :name, presence: true
	validates :ruc, presence: true, length:{ is: 11 }

	has_many :users
end
