class CreateJoinTablePublicationAttachment < ActiveRecord::Migration
  def change
    create_join_table :publications, :attachments do |t|
      # t.index [:publication_id, :attachment_id]
      # t.index [:attachment_id, :publication_id]
    end
  end
end
