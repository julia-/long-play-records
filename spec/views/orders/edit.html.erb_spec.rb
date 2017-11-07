require 'rails_helper'

RSpec.describe "orders/edit", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      :buyer => nil,
      :product => nil,
      :charge_identifier => "MyString"
    ))
  end

  it "renders the edit order form" do
    render

    assert_select "form[action=?][method=?]", order_path(@order), "post" do

      assert_select "input[name=?]", "order[buyer_id]"

      assert_select "input[name=?]", "order[product_id]"

      assert_select "input[name=?]", "order[charge_identifier]"
    end
  end
end
