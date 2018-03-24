# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'matches/edit', type: :view do
  before(:each) do
    @match = assign(:match, Match.create!(
                              player_one_id: 1,
                              player_two_id: 1
    ))
  end

  it 'renders the edit match form' do
    render

    assert_select 'form[action=?][method=?]', match_path(@match), 'post' do
      assert_select 'input[name=?]', 'match[player_one_id]'

      assert_select 'input[name=?]', 'match[player_two_id]'
    end
  end
end
