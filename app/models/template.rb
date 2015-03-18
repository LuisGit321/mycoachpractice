class Template
  include Mongoid::Document
  field :drive_id, type: String
  field :export_format, type: String
  field :content, type: String

  embedded_in :proposal

  def fetch_content
    api_client = GData::Client::DocList.new
    api_client.clientlogin(ENV["GACC_EMAIL"], ENV["GACC_PASS"])
    if drive_id.nil? and export_format.nil?
      self.drive_id = "12sIkgALHstfKOu_1XUbFfy5lNnrtdmL_zUYnhh0gPdY"
      self.export_format = "txt"
    end
    api_response = api_client.get("https://docs.google.com/feeds/download/documents/export/Export?id=#{drive_id}&exportFormat=#{export_format}")
    if api_response.status_code == 200
      self.content = api_response.body
    else
      errors[:api_errors] << api_response.body
    end
    save
  end

end
