ActiveAdmin.register TrainingProvider do
  
  action_item :only => :index do
    link_to 'Upload Training Providers', :action => 'upload_csv'
  end
  
  collection_action :upload_csv do
    render "admin/training_providers/upload_csv"
  end

  collection_action :import_csv, :method => :post do
    CsvDb.convert_save(params[:dump][:csv].tempfile)
    redirect_to :action => :index, :notice => "Training providers imported successfully!"
  end
  
  index do
    column :name
    column :email
    default_actions
  end
    show title: :name do |tp|
      attributes_table do
        row :name
        row :email
      end
      unless tp.training_programs.empty?
        panel "Programs" do
          table_for tp.training_programs  do
            column :name
            column :approval_type
            column :language
          end
        end
      end
    end
end
