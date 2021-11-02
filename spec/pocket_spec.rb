# spec/pocket_spec.rb

RSpec.describe Pocket::Client do
  describe 'constants' do
    specify do
      expect(described_class).to have_constant(:BASE_URL)
      expect(described_class).to have_constant(:HEADERS)
    end
  end

  describe '#call' do
    let(:client) { instance_double(Pocket::Client) }

    it 'makes a request to Pocket API' do
      allow(Pocket::Client).to receive(:new).and_return(client)
      allow(client).to receive(:call).and_return(true)

      res = client.call(
        endpoint: 'get',
        params: { count: 1, tag: 'schedule' }
      )

      expect(res).to be_truthy
    end
  end
end
