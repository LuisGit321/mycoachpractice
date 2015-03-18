class Lead
  include Mongoid::Document
  field :coach_id, type: String
  field :rfp_id, type: String
  field :coachee_id, type: String
  field :created_at, type: Time
  field :proposal_sent_at, type: Time
  field :coachee_name, type: String
  field :coachee_presenting_issue, type: String

  attr_accessible :coachee_name, :rfp_id, :coachee_presenting_issue,
                  :coachee_id, :created_id

  belongs_to :coach, class_name: "User", foreign_key: :coach_id
  has_one :proposal

  validates :rfp_id, presence: true

  def proposal_sent?
    !!proposal_sent_at
  end

  class << self
    def build_lead_attributes_from(api_response)
      attributes = {
        # rfp_id: api_response["id"],
        coachee_id: api_response["coachee_profile"]["user_id"],
        coachee_name: api_response["coachee_profile"]["name"],
        # coachee_presenting_issue: api_response["coachee_issue"]["answers"][0]["response"],
        created_at: Time.now
      }
    end
  end

end
