# require 'byebug'
require_relative '../../app/models/fetcher'

describe Fetcher do
  context 'When requesting the "Mac n Cheese Bites" recipe from Spoonacular' do
    f = Fetcher
    mac_n_cheese_id = 558_662
    response = f.request_recipe(mac_n_cheese_id)

    it 'should return a cuisine of American' do
      expect(*response['cuisines']).to eq 'american'
    end
  end
end
