class ProfileType
  include Mongoid::Document

  field :name, type: String

  attr_accessible :name

  has_many :users, validate: false

  validates :name, presence: true, uniqueness: true

end
