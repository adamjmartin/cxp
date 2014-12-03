# This needs to be loaded before sunspot/search/paginated_collection
# or #to_json gets defined in Object breaking delegation to Array via
# method_missing
if Rails::VERSION::MAJOR > 4 || (Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR >= 1)
  require 'active_support/core_ext/object/json'
else
  require 'active_support/core_ext/object/to_json'
end

require 'cxpbbg_rest'

require File.join(File.dirname(__FILE__),'cxpbbg_rest','configuration')
require File.join(File.dirname(__FILE__),'cxpbbg_rest', 'http_cxp')

#
# CxpbbgRest.push_content content
#
module CxpbbgRest #:nodoc:
    class <<self
      attr_writer :configuration, :http_cxp, :push_content
     
      def configuration
        @configuration ||= CxpbbgRest::Configuration.new
      end

      def reset
        @configuration = nil
      end
      
      def push_content content=nil
        if content
          @http_cxp ||= CxpbbgRest::HttpCxp.new content
          @http_cxp.push
        else
          msg = '{"contents":[{"title":"title1"},{"title":"title2"}]}'
          raise "  Error - push_content requires payload in format of #{msg}"
        end
      end
      
      private
      
    end
end
