class AddGoogleColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :gmail_email, :string
    add_column :users, :uid, :string
    add_column :users, :auth_token, :string
    add_column :users, :token_refresh, :string
  end
end
