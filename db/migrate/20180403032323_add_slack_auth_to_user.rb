class AddSlackAuthToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :slack_webhook_url, :string
  end
end
