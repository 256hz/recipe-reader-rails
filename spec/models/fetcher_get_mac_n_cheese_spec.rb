# require 'byebug'
require_relative '../../app/models/fetcher'

describe Fetcher do
  context 'When requesting the "Mac and Cheese Bites" recipe from Spoonacular' do
    f = Fetcher
    mac_n_cheese_id = 558_662
    response = f.request_recipe(mac_n_cheese_id)

    title = 'Mac and Cheese Bites'
    steps = response['analyzedInstructions'][0]['steps']

    it 'title should match Mac and Cheese Bites' do
      expect(response['title']).to eq title
    end

    it 'should return a cuisine of American' do
      expect(*response['cuisines']).to eq 'american'
    end

    it 'should return 7 dish types' do
      expect(response['dishTypes'].length).to eq 7
    end

    it 'should return 8 ingredients' do
      expect(response['extendedIngredients'].length).to eq 8
    end

    it 'should return 9 steps' do
      expect(steps.length).to eq 9
    end

    it 'all steps should have text and a number' do
      steps.each do |step|
        expect(step['step']).to be_truthy
        expect(step['number']).to be_truthy
      end
    end

    it 'should be vegetarian' do
      expect(response['vegetarian']).to be(true)
    end

    it 'should not be vegan' do
      expect(response['vegan']).to be(false)
    end
  end
end
