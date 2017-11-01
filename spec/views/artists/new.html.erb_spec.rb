require 'rails_helper'

RSpec.describe "artists/new", type: :view do
  before(:each) do
    assign(:artist, Artist.new(
      :name => "MyString",
      :biography => "MyText",
      :image_data => "MyText",
      :discog_number => "MyString"
    ))
  end

  it "renders new artist form" do
    render

    assert_select "form[action=?][method=?]", artists_path, "post" do

      assert_select "input[name=?]", "artist[name]"

      assert_select "textarea[name=?]", "artist[biography]"

      assert_select "textarea[name=?]", "artist[image_data]"

      assert_select "input[name=?]", "artist[discog_number]"
    end
  end
end
