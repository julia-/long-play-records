require 'rails_helper'

RSpec.describe "products/show", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :name => "Name",
      :price => 2.5,
      :postage => 3.5,
      :record_condition => "Record Condition",
      :sleeve_condition => "Sleeve Condition",
      :discogs_id => "Discogs",
      :description => "MyText",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/Record Condition/)
    expect(rendered).to match(/Sleeve Condition/)
    expect(rendered).to match(/Discogs/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
