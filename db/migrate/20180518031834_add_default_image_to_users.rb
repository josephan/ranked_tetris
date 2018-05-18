class AddDefaultImageToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :default_image, :integer

    User.all.each do |user|
      user.update(default_image: (0..6).to_a.sample)
    end
  end

  def down
    remove_column :users, :default_image
  end
end
