module Miniblog
  class Engine < ::Rails::Engine
    isolate_namespace Miniblog

    initializer :assets do |config|
      Rails.application.config.assets.precompile += %w(miniblog.css miniblog.js)
    end
  end
end
