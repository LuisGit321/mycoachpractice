class Program
  include Mongoid::Document
  field :start_from_date, type: Time
  field :end_date, type: Time
  field :coaching_media, type: String
  field :after_hours_availability, type: String
  field :additional_time_text, type: String
  field :number_of_sessions, type: Integer
  field :session_duration, type: String
  field :hours_notice_of_cancellation, type: String
  field :weeks_notice, type: String
  field :mediation_period, type: String

  embedded_in :proposal
end
