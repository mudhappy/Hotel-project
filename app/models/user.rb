class User < ApplicationRecord
  acts_as_token_authenticatable
  enum role: [:root, :admin, :employee]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # Validations
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  validate :employee_is_not_enterprise_empty 

  # Associations
  belongs_to :enterprise, optional: true

  # Callbacks
  after_initialize :set_default_role, if: :new_record?

  # Methods
  def enterprise
    super.nil? ? 'Aun no pertenece a una empresa' : super
  end

  private
  
  def set_default_role
    self.role ||= :employee
  end

  def employee_is_not_enterprise_empty
    if role == 'employee' && enterprise_id.nil?
      errors.add(:enterprise, "can't be blank")
    end
  end
end
