require 'rails_helper'

RSpec.describe "releases/new", type: :view do
  before(:each) do
    assign(:release, Release.new(
      :title => "MyString",
      :catalogue_number => "MyString",
      :format => "MyString",
      :country_code => "MyString",
      :image_data => "MyText",
      :artist => nil
    ))
  end

  it "renders new release form" do
    render

    assert_select "form[action=?][method=?]", releases_path, "post" do

      assert_select "input[name=?]", "release[title]"

      assert_select "input[name=?]", "release[catalogue_number]"

      assert_select "input[name=?]", "release[format]"

      assert_select "input[name=?]", "release[country_code]"

      assert_select "textarea[name=?]", "release[image_data]"

      assert_select "input[name=?]", "release[artist_id]"
    end
  end
end
