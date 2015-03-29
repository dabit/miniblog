# miniblog

CI:
[![Build Status](https://travis-ci.org/dabit/miniblog.svg?branch=master)](https://travis-ci.org/dabit/miniblog)

Code Climate:
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/dabit/miniblog)

Generic Blog engine, currently in use by [david.padilla.cc](http://david.padilla.cc).
Spiritual successor to [crowdblog](https://github.com/crowdint/crowdblog).

## Installation

Gemfile

    gem 'miniblog'

Bundle

    bundle install

Copy migrations

    rake miniblog:install:migrations

Run them

    rake db:migrate

Mount

    #
    # routes.rb
    #

    mount Miniblog::Engine => '/blog'

Enjoy.

Your Rails App should implement the "client facing" pages. Read posts from the
miniblog::Post model.

## Testing: Use with caution

If you are using it as a 'vanilla' installation, that is, without a lot of
customizations, you can use some specs that are included with the gem to make
sure your blog behaves properly.

Add this on your spec_helper, right after you require `rspec/rails`:

    require 'miniblog/rspec'
    require 'database_cleaner'

Your are going to need DatabaseCleaner to use truncation strategies for your
data. Add these lines to spec_helper.rb:

    Rspec.configure do |config|

      config.use_transactional_fixtures = false

      config.before(:suite) do
        DatabaseCleaner.strategy = :truncation
        DatabaseCleaner.clean_with(:truncation)
      end

      config.before(:each) do
        DatabaseCleaner.start
      end

      config.after(:each) do
        DatabaseCleaner.clean
      end
    end

Now, create a miniblog spec:

    #
    # spec/integration/miniblog_spec.rb
    #
    require 'spec_helper'

    describe "miniblog" do
      it_behaves_like "a miniblog"
    end

And run your specs. It should test miniblog properly.
