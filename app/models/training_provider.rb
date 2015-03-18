class TrainingProvider
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :description, type: String

 # embeds_many :training_programs do
 #   def actp
 #     @target.select { |program| program.approval_type == "ACTP" }
 #   end

 #   def find(id)
 #     where(id: id)
 #   end
 # end

  has_many :training_programs
  attr_accessible :name, :email

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
# validates :description, presence: true

  def self.actp_programs
    all.map { |t| t.training_programs.actp }.flatten
  end
end
