require './business/blogging/navigators/posts_navigator'

describe Blogging::Navigators::PostsNavigator do
  describe '.index' do
    let(:listener) { double }
    let(:has_more) { false }
    let(:posts) { [1,2,3,4] }

    before do
      allow(Blogging::Manager).to receive(:posts).and_return(posts)
      allow(Blogging::Manager).to receive(:has_more_posts?).and_return(has_more)
    end

    it "calls listener's render_resource with right params" do
      expect(listener).to receive(:render_resources).with(posts, has_more)

      described_class.index(listener)
    end
  end

  describe '.show' do
    let(:slug) { 'slug' }
    let(:listener) { double }
    let(:post) { double }

    before do
      allow(listener).to receive(:params).and_return(slug: slug)
      allow(Blogging::Manager).to receive(:post).with(slug).and_return(post)
    end

    it "calls listener's render_resource with right params" do
      expect(listener).to receive(:render_resource).with(post)

      described_class.show(listener)
    end
  end
end
