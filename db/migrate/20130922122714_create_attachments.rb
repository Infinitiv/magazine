class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :title
      t.binary :data
      t.string :mime_type
      t.binary :thumbnail
      t.text :content

      t.timestamps
    end
  end
end
