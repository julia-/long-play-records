require 'rails_helper'

RSpec.describe "artists/edit", type: :view do
  before(:each) do
    @artist = assign(:artist, Artist.create!(
      :name => "MyString",
      :biography => "MyText",
      :image_data => "MyText",
      :discog_number => "MyString"
    ))
  end

  it "renders the edit artist form" do
    render

    assert_select "form[action=?][method=?]", artist_path(@artist), "post" do

      assert_select "input[name=?]", "artist[name]"

      assert_select "textarea[name=?]", "artist[biography]"

      assert_select "textarea[name=?]", "artist[image_data]"

      assert_select "input[name=?]", "artist[discog_number]"
    end
  end
end
