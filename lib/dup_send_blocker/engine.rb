module DupSendBlocker
  class Engine < ::Rails::Engine
    isolate_namespace DupSendBlocker

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
