require 'rails_helper'

RSpec.describe "orders/new", type: :view do
  before(:each) do
    assign(:order, Order.new(
      :buyer => nil,
      :product => nil,
      :charge_identifier => "MyString"
    ))
  end

  it "renders new order form" do
    render

    assert_select "form[action=?][method=?]", orders_path, "post" do

      assert_select "input[name=?]", "order[buyer_id]"

      assert_select "input[name=?]", "order[product_id]"

      assert_select "input[name=?]", "order[charge_identifier]"
    end
  end
end
