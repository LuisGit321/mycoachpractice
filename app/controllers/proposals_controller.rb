class ProposalsController < ApplicationController

  respond_to :html, :json
  before_filter :authenticate_user!
  before_filter :load_lead, only: [ :new ]

  def index
    respond_with @proposals = current_user.proposals
  end

  def new
    @proposal = current_user.proposals.build
  end


  def create
    @proposal = current_user.proposals.build(params[:proposal])
    @proposal.template.attributes = params[:proposal][:template_attributes]
    @proposal.program.attributes = params[:proposal][:program_attributes]
    @proposal.save
    @proposal.template.save
    @proposal.program.save
    redirect_to proposal_path(@proposal)
  end

  def show
    @proposal = Proposal.find(params[:id])
    @proposal.render_doc_content
    respond_with @proposal
  end

  def edit
    respond_with @proposal = Proposal.find(params[:id])
  end

  def update
  end

  def delete
  end

  protected

  def load_lead
    @lead = Lead.find(params[:lead_id])
  end

end
