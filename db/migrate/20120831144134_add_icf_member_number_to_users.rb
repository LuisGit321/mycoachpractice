class AddIcfMemberNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :icf_member_number, :string
  end
end
