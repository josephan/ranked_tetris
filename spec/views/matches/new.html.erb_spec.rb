require 'rails_helper'

RSpec.describe "matches/new", type: :view do
  before(:each) do
    assign(:match, Match.new(
      :player_one_id => 1,
      :player_two_id => 1
    ))
  end

  it "renders new match form" do
    render

    assert_select "form[action=?][method=?]", matches_path, "post" do

      assert_select "input[name=?]", "match[player_one_id]"

      assert_select "input[name=?]", "match[player_two_id]"
    end
  end
end
