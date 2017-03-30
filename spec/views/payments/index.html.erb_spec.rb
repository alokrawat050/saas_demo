require 'rails_helper'

RSpec.describe "payments/index", type: :view do
  before(:each) do
    assign(:payments, [
      Payment.create!(),
      Payment.create!()
    ])
  end

  it "renders a list of payments" do
    render
  end
end
