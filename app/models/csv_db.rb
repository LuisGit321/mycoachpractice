require 'csv-mapper'
include CsvMapper
class CsvDb
  class << self
    # @param [Object] csv_data
    def convert_save(csv_data)
      results = CsvMapper.import(csv_data, type: :io) do
        start_at_row 2
        [organization,program,type,email,language]
      end
      results.each do   |result|
        if tp = TrainingProvider.where(name: result.organization).first
          tp.email = result.email                                                                                             # Update the email address just in case it changed
          if prog = tp.training_programs.where(name: result.program).first
            prog.approval_type = result.type                                                                                  # Update the type in case it expired or something
          else
            prog = tp.training_programs.create(approval_type: result.type, name: result.program, language: result.language)
          end
          prog.save!
        else 
          tp = TrainingProvider.create(name: result.organization, email: result.email)
          prog = tp.training_programs.create(approval_type: result.type, name: result.program, language: result.language)
          prog.save!
        end
        tp.save!
      end
    end
  end
end
