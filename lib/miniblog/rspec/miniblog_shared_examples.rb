shared_examples_for "a miniblog", :type => :feature do
  let(:post) do
    Miniblog::Post.create :title => 'A post title', :body => 'A post body', :state => :drafted
  end

  describe "Home" do
    it "shows published posts" do
      post.save!
      post.publish_as_publisher

      visit root_path

      within "#post_#{post.id}" do
        page.should have_content post.title
        page.should have_content post.body
      end
    end
  end

  describe "Admin" do
    describe "manage posts" do
      it "creates a post", :js => true do
        visit admin_posts_path
        click_link 'New Post'

        fill_in 'Title', :with => 'A post title'
        fill_in 'Body' , :with => 'A post body'
        click_button 'Update'

        page.current_path.should == admin_posts_path
        page.should have_content 'A post title'
      end

      context "a post exists" do
        before do
          post
          post.save!
        end

        it "edits a post" do
          visit admin_posts_path
          within "#post_#{post.id}" do
            click_link 'Edit'
          end

          fill_in 'Title', :with => 'A NEW post title'
          fill_in 'Body' , :with => 'A NEW post body'
          click_button 'Update'

          page.current_path.should == admin_posts_path
          page.should have_content 'A NEW post title'
        end

        it "deletes a post" do
          visit admin_posts_path

          within "#post_#{post.id}" do
            click_link 'Delete'
          end
          page.current_path.should == admin_posts_path
          page.should_not have_content 'A post title'
        end

        it "publishes a post", :js => true do
          visit admin_posts_path

          within "#post_#{post.id}" do
            button = find_link 'Publish'
            button.click

            post.reload.state.should eq 'published'
            post.status_change_records.last.state.should == 'publish'
            post.status_change_records.last.user.should  == ::User.last
          end
        end
      end
    end
  end
end
