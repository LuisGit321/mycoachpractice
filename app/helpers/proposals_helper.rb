module ProposalsHelper
  def resulting_document_link(proposal)
    format = proposal.template.export_format
    case format
    when "pdf"
      proposal_url(proposal)
    when "gdoc"
      proposal_url(proposal)
    when "pdf"
      proposal_url(proposal)
    end
  end
end
