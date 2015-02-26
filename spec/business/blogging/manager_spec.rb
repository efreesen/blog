require './business/blogging/manager'

describe Blogging::Manager do
  describe '.preview_posts' do
    context 'when size is passed' do
      let(:size) { 8 }

      it 'calls PostRepository.latest with size as param' do
        expect(Blogging::Repositories::PostRepository).to receive(:latest).with(size)

        described_class.preview_posts(size)
      end
    end

    context 'when size is not passed' do
      it 'calls PostRepository.latest with 5 as param' do
        expect(Blogging::Repositories::PostRepository).to receive(:latest).with(5)

        described_class.preview_posts
      end
    end
  end

  describe '.posts' do
    context 'when size is not passed' do
      it 'calls PostRepository.all' do
        expect(Blogging::Repositories::PostRepository).to receive(:all)

        described_class.posts
      end
    end
  end

  describe '.post' do
    context 'when slug is passed' do
      let(:slug) { 'slug' }

      it 'calls PostRepository.get with slug as param' do
        expect(Blogging::Repositories::PostRepository).to receive(:get).with(slug)

        described_class.post(slug)
      end
    end

    context 'when slug is nil' do
      it 'return nil' do
        expect(described_class.post(nil)).to be_nil
      end
    end
  end

  describe '.has_more_posts?' do
    context 'when slug is passed' do
      let(:size) { 7 }

      it 'calls PostRepository.has_more_posts? with size as param' do
        expect(Blogging::Repositories::PostRepository).to receive(:has_more_posts?).with(size)

        described_class.has_more_posts?(size)
      end
    end

    context 'when slug is not passed' do
      it 'calls PostRepository.has_more_posts? with 5 as param' do
        expect(Blogging::Repositories::PostRepository).to receive(:has_more_posts?).with(5)

        described_class.has_more_posts?
      end
    end
  end
end
