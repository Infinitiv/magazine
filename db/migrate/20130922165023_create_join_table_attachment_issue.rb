class CreateJoinTableAttachmentIssue < ActiveRecord::Migration
  def change
    create_join_table :attachments, :issues do |t|
      # t.index [:attachment_id, :issue_id]
      # t.index [:issue_id, :attachment_id]
    end
  end
end
