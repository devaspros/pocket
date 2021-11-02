# spec/pocket_spec.rb

RSpec.describe Pocket::Client do
  describe 'constants' do
    specify do
      expect(described_class).to have_constant(:BASE_URL)
      expect(described_class).to have_constant(:HEADERS)
    end
  end

  describe '#call' do
    let(:client) { described_class.new(consumer_key: 'hola', access_token: 'mundo') }

    it 'does it' do
      r = client.call(
        endpoint: 'get',
        params: { count: 1, tag: 'schedule' }
      )

      expect(r).to be_truthy
    end
  end
end
