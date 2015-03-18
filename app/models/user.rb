class User
  require 'open-uri'

  include Mongoid::Document
  include Mongoid::Timestamps

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable

  # Database authenticatable
  field :email,                  type: String
  field :encrypted_password,     type: String, default: ""

  # Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  # Rememberable
  field :remember_created_at,    type: Time

  # Trackable
  field :sign_in_count,          type: Integer, default: 0
  field :current_sign_in_at,     type: Time
  field :last_sign_in_at,        type: Time
  field :current_sign_in_ip,     type: String
  field :last_sign_in_ip,        type: String

  # Confirmable
  field :confirmation_token,     type: String
  field :confirmed_at,           type: Time
  field :confirmation_sent_at,   type: Time
  field :unconfirmed_email,      type: String # Only if using reconfirmable

  # Application specific
  field :profile_type_id,        type: String
  field :icf_member_number,      type: Integer
  field :first_name,             type: String
  field :last_name,              type: String
  field :training_program_id,    type: String

  field :graduation_date,        type: Time

  # provider confirmation
  field :provider_confirmation_token,   type: String
  field :provider_confirmed_at,         type: Time
  field :provider_confirmation_sent_at, type: Time

  index({ email: 1}, {unique: true, background: true})

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :confirmed_at, :profile_type_id, :first_name, :last_name,
                  :icf_member_number, :training_program_id, :graduation_date

  attr_reader :full_name

  belongs_to :profile_type
  belongs_to :training_program, foreign_key: :training_program_id
  has_many :proposals, foreign_key: :created_by_id
  has_many :leads, foreign_key: :coach_id


  validates :password,
    presence: true,
    confirmation: true,
    length: { minimum: 5, maximum: 16 }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :profile_type_id, presence: true
  validates :encrypted_password, presence: true


  with_options if: :is_icf_member? do |member|
    member.validates :icf_member_number,
      presence: true,
      length: { is: 7 },
      uniqueness: true
    member.validate  :icf_credentials_match, unless: "icf_member_number.nil?"
  end

  with_options if: :is_student? do |student|
    student.validates :training_program_id,
      presence: { message: "Training program can't be blank" }
    student.validates :graduation_date,
      presence: { message: "Graduation date can't be blank" }
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def is_student?
    profile_type.name == "Student" if profile_type.present?
  end

  def is_icf_member?
    profile_type.name == "ICF Member" if profile_type.present?
  end

  def icf_credentials_match
    site_data = Nokogiri::XML(open("http://nnf.coachfederation.org/profiles/members.aspx?memberID=#{icf_member_number}"))
    email = site_data.xpath("//body//form//table//tr//td//div//table//tr//td//TABLE//TR//TD//table//tr//TD")
    full_name = site_data.xpath("//H2")
    unless full_name.nil? or email[9].nil?
      {
        email:      email[9].text().split('>')[0].split(':')[1],
        last_name:  full_name.text().split(" ").last
      }.each { |k, v| errors[k] << "#{k.to_s.gsub(/_/, " ").capitalize} cannot be verified with ICF directory." unless v == send(k) }
    else
      errors[:icf_member_number] << "Icf membership number not found in ICF directory."
    end
  end

  def provider_confirmation_sent?
    !!provider_confirmation_sent_at
  end

  def provider_confirmed?
    !!provider_confirmed_at
  end

  def request_provider_confirmation
    provider = training_program.training_provider
    Notifier.student_signup_for_provider(self, provider).deliver
    self.provider_confirmation_sent_at = Time.now
    save(validate: false)
  end

  def generate_provider_confirmation_token
    self.provider_confirmation_token = SecureRandom.hex(8)
    save(validate: false)
  end

  def confirm_by_provider
    self.provider_confirmation_token = nil
    self.provider_confirmed_at = Time.now
    save(validate: false)
  end

  class << self
    def confirm_by_provider_token(token)
      student = find_by(provider_confirmation_token: token)
      student.confirm_by_provider
      student
    end
  end
end
