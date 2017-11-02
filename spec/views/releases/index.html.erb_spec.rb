require 'rails_helper'

RSpec.describe "releases/index", type: :view do
  before(:each) do
    assign(:releases, [
      Release.create!(
        :title => "Title",
        :catalogue_number => "Catalogue Number",
        :format => "Format",
        :country_code => "Country Code",
        :image_data => "MyText",
        :artist => nil
      ),
      Release.create!(
        :title => "Title",
        :catalogue_number => "Catalogue Number",
        :format => "Format",
        :country_code => "Country Code",
        :image_data => "MyText",
        :artist => nil
      )
    ])
  end

  it "renders a list of releases" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Catalogue Number".to_s, :count => 2
    assert_select "tr>td", :text => "Format".to_s, :count => 2
    assert_select "tr>td", :text => "Country Code".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
