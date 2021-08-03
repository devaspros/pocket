# spec/pocket_spec.rb

RSpec.describe Pocket::Client do
  let(:client) { described_class.new(consumer_key: 'hola', access_token: 'mundo') }

  describe '#call' do
    it 'does it' do
      r = client.call(
        endpoint: 'get',
        params: { count: 1, tag: 'schedule' }
      )

      expect(r).to be_truthy
    end
  end
end
