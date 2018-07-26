class User < ApplicationRecord
  acts_as_token_authenticatable
  enum role: [:root, :admin, :employee]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # Validations
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  validate :employee_has_to_belong_a_enterprise 

  # Associations
  belongs_to :enterprise, optional: true

  # Callbacks
  after_initialize :set_default_role, if: :new_record?

  # Methods
  def enterprise
    super.nil? ? 'Aun no pertenece a una empresa' : super
  end

  def have_enterprise?
    enterprise_id.nil? ? false : true
  end

  def set_enterprise(enterprise)
    self.enterprise_id = enterprise.id
    self.save
  end

  def belongs_to_enterprise?(id)
    enterprise.id == id.to_i
  end

  private

  def set_default_role
    self.role ||= :admin
  end

  def employee_has_to_belong_a_enterprise
    if role == 'employee' && enterprise_id.nil?
      errors.add(:enterprise, "can't be blank")
    end
  end
end
