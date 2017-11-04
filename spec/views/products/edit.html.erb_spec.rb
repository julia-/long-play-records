require 'rails_helper'

RSpec.describe "products/edit", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :name => "MyString",
      :price => 1.5,
      :postage => 1.5,
      :record_condition => "MyString",
      :sleeve_condition => "MyString",
      :discogs_id => "MyString",
      :description => "MyText",
      :user => nil
    ))
  end

  it "renders the edit product form" do
    render

    assert_select "form[action=?][method=?]", product_path(@product), "post" do

      assert_select "input[name=?]", "product[name]"

      assert_select "input[name=?]", "product[price]"

      assert_select "input[name=?]", "product[postage]"

      assert_select "input[name=?]", "product[record_condition]"

      assert_select "input[name=?]", "product[sleeve_condition]"

      assert_select "input[name=?]", "product[discogs_id]"

      assert_select "textarea[name=?]", "product[description]"

      assert_select "input[name=?]", "product[user_id]"
    end
  end
end
