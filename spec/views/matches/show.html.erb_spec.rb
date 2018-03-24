# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'matches/show', type: :view do
  before(:each) do
    @match = assign(:match, Match.create!(
                              player_one_id: 2,
                              player_two_id: 3
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
