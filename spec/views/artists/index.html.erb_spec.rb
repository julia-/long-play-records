require 'rails_helper'

RSpec.describe "artists/index", type: :view do
  before(:each) do
    assign(:artists, [
      Artist.create!(
        :name => "Name",
        :biography => "MyText",
        :image_data => "MyText",
        :discog_number => "Discog Number"
      ),
      Artist.create!(
        :name => "Name",
        :biography => "MyText",
        :image_data => "MyText",
        :discog_number => "Discog Number"
      )
    ])
  end

  it "renders a list of artists" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Discog Number".to_s, :count => 2
  end
end
