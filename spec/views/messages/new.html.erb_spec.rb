require 'rails_helper'

RSpec.describe "messages/new", type: :view do
  before(:each) do
    assign(:message, Message.new(
      :conversation => nil,
      :sender => nil,
      :content => "MyText"
    ))
  end

  it "renders new message form" do
    render

    assert_select "form[action=?][method=?]", messages_path, "post" do

      assert_select "input[name=?]", "message[conversation_id]"

      assert_select "input[name=?]", "message[sender_id]"

      assert_select "textarea[name=?]", "message[content]"
    end
  end
end
