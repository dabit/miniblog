shared_examples_for "a miniblog", :type => :feature do
  let(:post) do
    Miniblog::Post.create! :title => 'A post title', :body => 'A post body', :state => :drafted
  end

  describe "Home" do
    it "shows published posts" do
      post.save!
      post.publish

      visit root_path

      within "#post_#{post.id}" do
        expect(page).to have_content post.title
        expect(page).to have_content post.body
      end
    end
  end

  describe "Admin" do
    describe "manage posts" do
      it "creates a post", :js => true do
        visit admin_posts_path
        click_link 'Click here for new post'

        fill_in 'Title', :with => 'A post title'
        fill_in 'Body' , :with => 'A post body'
        click_button 'Save'

        post = Miniblog::Post.last
        expect(page.current_path).to eq edit_admin_post_path(post)
      end

      context "a post exists" do
        before do
          post
          post.save!
        end

        it "edits a post" do
          visit admin_posts_path
          within "#post_#{post.id}" do
            click_link 'Edit', match: :first
          end

          fill_in 'Title', :with => 'A NEW post title'
          fill_in 'Body' , :with => 'A NEW post body'
          click_button 'Update'

          expect(page.current_path).to eq admin_post_path(post)
          expect(post.reload.title).to eq 'A NEW post title'
        end

        it "previews a post" do
          visit admin_posts_path
          within "#post_#{post.id}" do
            click_link 'Edit', match: :first
          end

          click_link 'Preview'
          expect(page.current_path).to eq admin_preview_path(post)
        end

        it "deletes a post" do
          visit admin_posts_path

          within "#post_#{post.id}" do
            click_link 'Delete', match: :first
          end
          expect(page.current_path).to eq admin_posts_path
          expect(page).to_not have_content 'A post title'
        end

        it "publishes a post", :js => true do
          visit admin_posts_path

          within "#post_#{post.id}" do
            button = find_link 'Publish'
            button.click

            expect(post.reload.state).to eq 'published'
          end
        end
      end
    end
  end
end
