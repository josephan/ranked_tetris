require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    won_matches: Field::HasMany.with_options(class_name: "Match"),
    comments: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    password: Field::String,
    elo: Field::Number,
    retired: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    email: Field::String,
    admin: Field::Boolean,
    slack_webhook_url: Field::String
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :won_matches,
    :comments,
    :id,
    :name,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :won_matches,
    :comments,
    :id,
    :name,
    :elo,
    :retired,
    :created_at,
    :updated_at,
    :email,
    :admin,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :won_matches,
    :comments,
    :name,
    :retired,
    :email,
    :admin,
    :slack_webhook_url,
    :elo,
    :password,
  ].freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(user)
  #   "User ##{user.id}"
  # end
end
