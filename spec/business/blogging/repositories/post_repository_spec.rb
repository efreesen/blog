require 'ostruct'

require './business/blogging/repositories/post_repository'

describe Blogging::Repositories::PostRepository do
  before do
    class Post
      attr_accessor :slug, :title, :errors
      def initialize(hash); @slug = hash[:slug]; end
      def self.with_slug(args); self; end
      def self.first_or_initialize; self; end
      def self.find_by(args);end
      def self.limit(size); []; end
      def self.published; self; end
      def self.count; 0; end
      def update_attributes(hash); end
      def user; OpenStruct.new(name: 'name'); end
      def attributes; {slug: slug}; end
    end
  end

  describe '.save' do
    context 'when post is passed,' do
      context 'the post is found' do
        context 'and save is successful' do
          let(:title) { 'Nice title' }
          let(:slug) { 'nice-title' }
          let(:result) { Post.new title: title, slug: slug }
          let(:post) { Blogging::Entities::PostEntity.new(title: title) }

          before do
            allow(Post).to receive(:first_or_initialize).and_return(result)
            allow(result).to receive(:attributes).and_return(slug: slug)
            allow(result).to receive(:update_attributes).with(post.attributes).and_return(true)
          end

          subject { described_class.save(post) }

          it 'returns true' do
            expect(subject).to be
          end

          it 'sets post slug' do
            result = subject

            expect(result.slug).to eq slug
          end
        end

        context 'and save is not successful' do
          let(:title) { 'Nice title' }
          let(:slug) { 'nice-title' }
          let(:result) { Post.new title: title, slug: slug, errors: 'errors' }
          let(:post) { Blogging::Entities::PostEntity.new(title: title, slug: slug) }

          before do
            allow(Post).to receive(:first_or_initialize).and_return(result)
            allow(result).to receive(:attributes).and_return(errors: 'errors')
            allow(result).to receive(:update_attributes).with(post.attributes).and_return(false)
          end

          subject { described_class.save(post) }

          it 'returns true' do
            expect(subject).to be
          end

          it 'sets post errors' do
            entity = subject

            expect(entity.errors).to eq 'errors'
          end
        end
      end

      context 'and a post is not found' do
        let(:slug) { 'slug' }
        let(:result) { nil }
        let(:post) { Blogging::Entities::PostEntity.new(slug: slug) }

        before do
          allow(Post).to receive(:find_by).with(slug: slug).and_return(result)
        end

        it 'returns post' do
          expect(described_class.get(slug)).to be_nil
        end
      end

      context 'and slug is nil' do
        let(:slug) { nil }

        it 'returns post' do
          expect(described_class.get(slug)).to be_nil
        end
      end
    end

    context 'when slug is not passed' do
      it 'returns nil' do
        expect{described_class.get}.to raise_error(ArgumentError)
      end
    end
  end

  describe '.get' do
    context 'when slug is passed' do
      context 'and a post is found' do
        let(:slug) { 'slug' }
        let(:result) { Post.new slug: slug }
        let(:post) { Blogging::Entities::PostEntity.new(slug: slug, user_name: 'name') }

        before do
          allow(Post).to receive(:find_by).with(slug: slug).and_return(result)
          allow(Blogging::Entities::PostEntity).to receive(:new).with(slug: slug, user_name: 'name').and_return(post)
        end

        it 'returns post' do
          expect(described_class.get(slug)).to eq post
        end
      end

      context 'and a post is not found' do
        let(:slug) { 'slug' }
        let(:result) { nil }
        let(:post) { Blogging::Entities::PostEntity.new(slug: slug) }

        before do
          allow(Post).to receive(:find_by).with(slug: slug).and_return(result)
        end

        it 'returns post' do
          expect(described_class.get(slug)).to be_nil
        end
      end

      context 'and slug is nil' do
        let(:slug) { nil }

        it 'returns post' do
          expect(described_class.get(slug)).to be_nil
        end
      end
    end

    context 'when slug is not passed' do
      it 'returns nil' do
        expect{described_class.get}.to raise_error(ArgumentError)
      end
    end
  end

  describe '.latest' do
    context 'when size is passed' do
      let(:size) { 8 }
      let(:slug) { 'slug' }

      context 'and exists more than 8 posts' do
        let(:collection) do
          array = []

          10.times do |i|
            array.push Post.new(slug: "#{slug}#{i}")
          end

          array
        end
        let(:result) do
          array = []

          size.times do |i|
            array.push Blogging::Entities::PostEntity.new(slug: "#{slug}#{i}")
          end

          array
        end
        let(:filtered_collection) { collection[0..size-1] }

        before do
          allow(Post).to receive(:limit).and_return(filtered_collection)
        end

        it 'returns 8 posts' do
          expect(described_class.latest(size).size).to eq size
        end

        it 'returns first 8 posts from collection' do
          returned_array = described_class.latest(size).map &:slug
          expected_array = result.map &:slug

          expect(returned_array).to eq expected_array
        end
      end

      context 'and exists less than 8 posts' do
        let(:collection) do
          array = []

          6.times do |i|
            array.push Post.new(slug: "#{slug}#{i}")
          end

          array
        end
        let(:result) do
          array = []

          6.times do |i|
            array.push Blogging::Entities::PostEntity.new(slug: "#{slug}#{i}")
          end

          array
        end

        before do
          allow(Post).to receive(:limit).and_return(collection)
        end

        it 'returns 6 posts' do
          expect(described_class.latest(size).size).to eq 6
        end

        it 'returns first 6 posts from collection' do
          returned_array = described_class.latest(size).map &:slug
          expected_array = result.map &:slug

          expect(returned_array).to eq expected_array
        end
      end

      context 'and there are no posts' do
        let(:collection) { [] }

        before do
          allow(Post).to receive(:limit).and_return(collection)
        end

        it 'returns 0 posts' do
          expect(described_class.latest(size).size).to eq 0
        end

        it 'returns an empty array' do
          expect(described_class.latest(size)).to be_empty
        end
      end
    end

    context 'when size is not passed' do
      let(:size) { 5 }
      let(:slug) { 'slug' }

      let(:collection) do
        array = []

        10.times do |i|
          array.push Post.new(slug: "#{slug}#{i}")
        end

        array
      end
      let(:result) do
        array = []

        size.times do |i|
          array.push Blogging::Entities::PostEntity.new(slug: "#{slug}#{i}")
        end

        array
      end
      let(:filtered_collection) { collection[0..size-1] }

      before do
        allow(Post).to receive(:limit).and_return(filtered_collection)
      end

      it 'returns 5 posts' do
        expect(described_class.latest(size).size).to eq size
      end

      it 'returns first 5 posts from collection' do
        returned_array = described_class.latest(size).map &:slug
        expected_array = result.map &:slug

        expect(returned_array).to eq expected_array
      end
    end

    context 'when slug is nil' do
      let(:size) { nil }

      it 'return an empty array' do
        expect(described_class.latest(size)).to be_empty
      end
    end
  end

  describe '.has_more_posts?' do
    context 'when there are less than size posts' do
      let(:size) { 5 }

      before do
        allow(Post).to receive(:count).and_return 3
      end

      subject { described_class.has_more_posts?(size) }

      it 'returns false' do
        expect(subject).not_to be
      end
    end

    context 'when there are more than size posts' do
      let(:size) { 5 }

      before do
        allow(Post).to receive(:count).and_return 6
      end

      subject { described_class.has_more_posts?(size) }

      it 'returns false' do
        expect(subject).to be
      end
    end
  end
end
