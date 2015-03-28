require 'spec_helper'

module Miniblog
  describe Post do
    describe 'Class Methods' do
      describe '#self.all_posts_json' do
        it 'convert ordered posts to JSON' do
          expect(Post).to receive(:order_by_publish_date).and_return Post
          expect(Post).to receive(:to_json)
          Post.all_posts_json
        end
      end

      describe '#self.last_published' do
        it 'should find the last given post published, ordered' do
          expect(Post).to receive(:published_and_ordered).and_return Post
          expect(Post).to receive(:limit).with(11)
          Post.last_published(11)
        end
      end

      describe '#self.order_by_publish_date' do
        it 'should order by published' do
          expect(Post).to receive(:order).with('published_at DESC, created_at DESC, id DESC')
          Post.order_by_publish_date
        end
      end

      describe '#self.published' do
        it 'should only find Published Posts' do
          expect(Post).to receive(:where).with(state: 'published')
          Post.published
        end
      end

      describe '#self.published_and_ordered' do
        it 'should find published posts and order them by published date (FILO)' do
          expect(Post).to receive(:published).and_return Post
          expect(Post).to receive(:order_by_publish_date).and_return Post
          Post.published_and_ordered
        end
      end

      describe '#self.scoped_for' do
        let(:user) { double(is_publisher?: true) }

        context 'user is publisher' do
          it 'should see all the Posts' do
            expect(Post.scoped_for(user)).to eq Post.all
          end
        end

        context 'user is not publisher' do
          before { expect(user).to receive(:is_publisher?).and_return false }

          it 'should see my own Posts only' do
            expect(user).to receive(:authored_posts)
            Post.scoped_for(user)
          end
        end
      end
    end

    describe "#allowed_to_update_permalink?" do
      context "post is published" do
        before do
          subject.state = 'published'
        end

        it "returns false" do
          expect(subject.allowed_to_update_permalink?).to be_falsey
        end
      end

      context "post is not published" do
        before do
          subject.state = 'draft'
        end

        it "returns true" do
          expect(subject.allowed_to_update_permalink?).to be_truthy
        end
      end
    end

    describe "#day" do
      context "published at in february" do
        before do
          subject.published_at = Date.new(2012, 12, 2)
        end

        it "returns 02" do
          expect(subject.day).to eq "02"
        end
      end
    end

    describe "#formatted_published_date" do
      it "Formats the published_at date" do
        subject.published_at = Time.zone.parse('2012/02/18')
        expect(subject.formatted_published_date).to eq 'Feb 18, 2012'
      end
    end

    describe '#html_body' do
      before { expect(subject).to receive(:body).and_return '**w00t**' }

      it 'should parse the Markdown in the body' do
        expect(subject.html_body).to match /<strong>w00t<\/strong>/
      end
    end

    describe "#month" do
      context "published at in february" do
        before do
          subject.published_at = Date.new(2012, 2, 1)
        end

        it "returns 02" do
          expect(subject.month).to eq "02"
        end
      end
    end

    describe "#publish_if_allowed" do
      context "user is publisher" do
        let(:user) { stub_model(::User, :is_publisher? => true) }
        it "changes its state" do
          expect(subject).to receive(:publisher=).with(user)
          expect(subject).to receive('publish')
          subject.publish_if_allowed('publish', user)
        end
      end

      context "user is not publisher" do
        let(:user) { stub_model(::User, :is_publisher? => false) }

        it "does not change its state" do
          expect(subject).to_not receive('publish')
          subject.publish_if_allowed('publish', user)
        end
      end
    end

    describe "#regenerate_permalink" do
      it "generates the permalink based on the post title" do
        subject.title = 'A big long post title'
        subject.regenerate_permalink
        expect(subject.permalink).to eq 'a-big-long-post-title'
      end
    end

    describe '#url_params' do
      before { subject.stub(year: 'YEAR', month: 'MONTH',
                            day: 'DAY', permalink: 'PERMALINK') }

      it 'should return the array for permalink (year/month/day/permalink)' do
        expect(subject.url_params).to eq %w(YEAR MONTH DAY PERMALINK html)
      end
    end

  end
end
