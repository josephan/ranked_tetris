require "administrate/base_dashboard"

class MatchDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    player_one: Field::BelongsTo.with_options(class_name: "User"),
    player_two: Field::BelongsTo.with_options(class_name: "User"),
    winner: Field::BelongsTo.with_options(class_name: "User"),
    comments: Field::HasMany,
    id: Field::String.with_options(searchable: false),
    player_one_id: Field::Number,
    player_two_id: Field::Number,
    winner_id: Field::Number,
    player_one_won: Field::Boolean,
    player_one_elo_delta: Field::Number,
    player_two_elo_delta: Field::Number,
    confirmation_uuid: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    player_one_rounds_won: Field::Number,
    player_two_rounds_won: Field::Number,
    comments_count: Field::Number,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :player_one,
    :player_two,
    :winner,
    :comments,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :player_one,
    :player_two,
    :winner,
    :comments,
    :id,
    :player_one_id,
    :player_two_id,
    :winner_id,
    :player_one_won,
    :player_one_elo_delta,
    :player_two_elo_delta,
    :confirmation_uuid,
    :created_at,
    :updated_at,
    :player_one_rounds_won,
    :player_two_rounds_won,
    :comments_count,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :player_one,
    :player_two,
    :winner,
    :comments,
    :player_one_id,
    :player_two_id,
    :winner_id,
    :player_one_won,
    :player_one_elo_delta,
    :player_two_elo_delta,
    :confirmation_uuid,
    :player_one_rounds_won,
    :player_two_rounds_won,
    :comments_count,
  ].freeze

  # Overwrite this method to customize how matches are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(match)
  #   "Match ##{match.id}"
  # end
end
