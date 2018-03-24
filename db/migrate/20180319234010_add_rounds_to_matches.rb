# frozen_string_literal: true

class AddRoundsToMatches < ActiveRecord::Migration[5.1]
  def change
    add_column :matches, :player_one_rounds_won, :integer, default: 0
    add_column :matches, :player_two_rounds_won, :integer, default: 0
  end
end
