class TrainingProgram
  include Mongoid::Document
  field :name,                 type: String
  field :approval_type,        type: String
  field :description,          type: String
  field :language,             type: String
  field :training_provider_id, type: String
  belongs_to :training_provider
  has_many :students, class_name: "User", foreign_key: :training_program_id

  attr_reader :title
  attr_accessible :name, :approval_type, :language

  validates :name, presence: true, uniqueness: true
  validates :approval_type, presence: true
  validates :language, presence: true
# validates :description, presence: true

  def title
    "#{training_provider.name} - #{name}"
  end
end
