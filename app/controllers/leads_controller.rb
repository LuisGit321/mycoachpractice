class LeadsController < ApplicationController
  respond_to :json, :html
  protect_from_forgery except: :create

  before_filter :retrieve_rfp_details, only: :show

  def index
    @leads = Lead.all
    respond_with @leads
  end

  # post /leads.json
  def create
    @lead = Lead.new(
      rfp_id: params[:rfp_id],
      coachee_presenting_issue: params[:coachee_presenting_issue],
      created_at: Time.now
    )
    @lead.save
    respond_with @lead
  end

  def show
    respond_with @lead
  end

  def edit
    @lead = Lead.find(params[:id])
    respond_with @lead
  end

  def update
    @lead = Lead.find(params[:id])
    @lead.update_attributes(params[:lead])
    respond_with @lead
  end

  def delete
    @lead = Lead.find(params[:id])
    @lead.destroy
    redirect_to leads_url
  end

  protected

  def retrieve_rfp_details
    uri = URI("http://coachaxis-test.herokuapp.com/request_for_proposals/#{lead.rfp_id}.json")
    req = Net::HTTP::Get.new(uri.path)
    res = Net::HTTP.start(uri.hostname, uri.port){ |http| http.request(req) }
    api_response = JSON.parse(res.body)
    attributes = Lead.build_lead_attributes_from api_response
    lead.update_attributes(attributes)
  end

  def lead
    @lead ||= Lead.find(params[:id])
  end
end
