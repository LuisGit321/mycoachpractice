class Proposal
  include Mongoid::Document
  field :created_by_id, type: String
  field :created_for_id, type: String
  field :lead_id, type: String
  field :created_at, type: Time
  field :doc_content, type: String
  field :sent_at, type: Time
  field :url, type: String

  belongs_to :lead
  belongs_to :coach, class_name: "User", foreign_key: :created_by_id
  embeds_one :program, autobuild: true
  embeds_one :template, autobuild: true

  attr_accessible :text_body, :created_at, :lead_id, :created_by_id, :url, :created_at

  accepts_nested_attributes_for :program, :template
  validates :lead_id, presence: true

  after_create do |p|
    p.template.save
    p.program.save
  end

  def render_doc_content
    errors[:parse_template] << "Template error"
    template.fetch_content
    template_content = template.content
    parse_fields = template_content.scan(/<<\w+>>/)
    parse_fields.each do |field|
      if val = send(field.split("_", 2).first.gsub!(/<</, '')).send(field.split("_", 2).last.gsub!(/>>/, '')).to_s
        template_content.gsub!(field, val)
      end
    end
    self.doc_content = template_content
    save(validate: false)
  end

  def post_to_coachaxis
    uri = URI("http://coachaxis-test.herokuapp.com/proposals.json")
    req = Net::HTTP::Post.new(uri.path)
    req.body = {
      proposal: {
        lead_id: self.lead_id,
        coach_id: self.created_by_id,
        coach_name: self.coach.full_name,
        url: "/proposals/#{self.id}",
        user_id: self.lead.coachee_id,
        rfp_id: self.lead.rfp_id,
      }
    }.to_json

    res = Net::HTTP.start(uri.hostname, uri.port){ |http| http.request(req) }
    if res.code == "200"
      self.created_at = Time.now
      save(validate: false)
    else
      errors[:coachaxis] << "#{res.code} - #{res.body}"
    end
  end
end
