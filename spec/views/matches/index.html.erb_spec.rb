require 'rails_helper'

RSpec.describe "matches/index", type: :view do
  before(:each) do
    assign(:matches, [
      Match.create!(
        :player_one_id => 2,
        :player_two_id => 3
      ),
      Match.create!(
        :player_one_id => 2,
        :player_two_id => 3
      )
    ])
  end

  it "renders a list of matches" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
