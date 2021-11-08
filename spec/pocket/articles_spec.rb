# spec/pocket/articles_spec.rb

RSpec.describe Pocket::Articles do
  describe 'constants' do
    specify do
      expect(described_class).to have_constant(:RETRIEVE_ENDPOINT)
      expect(described_class).to have_constant(:REQUEST_PARAMS)
      expect(described_class).to have_constant(:MODIFY_ENDPOINT)
    end
  end

  describe '#articles' do
    context 'with scheduled articles' do
      let(:articles_client) { described_class.new }

      let(:successful_response) do
        JSON.dump(
          {
            'status' => 1,
            'list' => {
              '12345' => {
                'item_id' => 12345,
                'resolved_url' => 'https://google.com/',
                'resolved_title' => 'Google Dot Com',
                'excerpt' => 'content drawable'
              }
            }
          }
        )
      end

      it 'returns list of articles' do
        stub_request(:post, 'https://getpocket.com/v3/get')
          .to_return(
            status: 200,
            body: successful_response
          )

        res = articles_client.articles

        expect(res).not_to be_empty
      end
    end
  end

  describe '#batch_archive' do
    let(:archive_client) { described_class.new }
    let(:archivable_ids) do
      ['3461292822', '2972707538']
    end

    context 'with articles to archive' do
      it 'archives them' do
        stub_request(:post, 'https://getpocket.com/v3/send')
          .to_return(status: 200)

        res = archive_client.batch_archive(archivable_ids)

        expect(res).to eq('Todo fine')
      end
    end
  end
end
