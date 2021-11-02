# spec/pocket/articles_spec.rb

RSpec.describe Pocket::Articles do
  describe 'constants' do
    specify do
      expect(described_class).to have_constant(:RETRIEVE_ENDPOINT)
      expect(described_class).to have_constant(:ARTICLE_COUNT)
      expect(described_class).to have_constant(:ARTICLE_TAG)
      expect(described_class).to have_constant(:REQUEST_PARAMS)
      expect(described_class).to have_constant(:MODIFY_ENDPOINT)
    end
  end
end
