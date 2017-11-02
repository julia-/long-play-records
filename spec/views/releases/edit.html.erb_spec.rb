require 'rails_helper'

RSpec.describe "releases/edit", type: :view do
  before(:each) do
    @release = assign(:release, Release.create!(
      :title => "MyString",
      :catalogue_number => "MyString",
      :format => "MyString",
      :country_code => "MyString",
      :image_data => "MyText",
      :artist => nil
    ))
  end

  it "renders the edit release form" do
    render

    assert_select "form[action=?][method=?]", release_path(@release), "post" do

      assert_select "input[name=?]", "release[title]"

      assert_select "input[name=?]", "release[catalogue_number]"

      assert_select "input[name=?]", "release[format]"

      assert_select "input[name=?]", "release[country_code]"

      assert_select "textarea[name=?]", "release[image_data]"

      assert_select "input[name=?]", "release[artist_id]"
    end
  end
end
