require 'rails_helper'

RSpec.describe "releases/show", type: :view do
  before(:each) do
    @release = assign(:release, Release.create!(
      :title => "Title",
      :catalogue_number => "Catalogue Number",
      :format => "Format",
      :country_code => "Country Code",
      :image_data => "MyText",
      :artist => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Catalogue Number/)
    expect(rendered).to match(/Format/)
    expect(rendered).to match(/Country Code/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
