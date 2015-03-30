module Miniblog
  class Engine < ::Rails::Engine
    isolate_namespace Miniblog

    initializer :assets do |config|
      Rails.application.config.assets.precompile += %w(miniblog.css miniblog.js)
    end

    config.to_prepare do
      Dir.glob(Rails.root + "app/decorators/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end
  end
end
