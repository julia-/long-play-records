require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        :name => "Name",
        :price => 2.5,
        :postage => 3.5,
        :record_condition => "Record Condition",
        :sleeve_condition => "Sleeve Condition",
        :discogs_id => "Discogs",
        :description => "MyText",
        :user => nil
      ),
      Product.create!(
        :name => "Name",
        :price => 2.5,
        :postage => 3.5,
        :record_condition => "Record Condition",
        :sleeve_condition => "Sleeve Condition",
        :discogs_id => "Discogs",
        :description => "MyText",
        :user => nil
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => "Record Condition".to_s, :count => 2
    assert_select "tr>td", :text => "Sleeve Condition".to_s, :count => 2
    assert_select "tr>td", :text => "Discogs".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
