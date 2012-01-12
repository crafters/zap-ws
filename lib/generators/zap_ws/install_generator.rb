module ZapWs
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      desc "Creates the zap config initializer on config/initializers/zap.rb."

      def copy_initializer_file
        template "initializer.rb", "config/initializers/zap.rb"
      end
    end
  end
end