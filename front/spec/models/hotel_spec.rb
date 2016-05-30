require "rails_helper"

RSpec.describe Hotel, type: :model do


  it "should be able to get html" do
    stub_http_response_with('[{"id": 1,"name": "Grand Budapest Hotel"}]')
    expect(Hotel.get('').parsed_response).to eq('[{"id": 1,"name": "Grand Budapest Hotel"}]'.to_json)
  end



end
