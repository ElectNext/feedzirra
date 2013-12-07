module Feedzirra

  module Parser
    # Parser for dealing with RSS feeds.
    class EnxtDMN
      include SAXMachine
      include FeedUtilities
      element :title
      element :description
      element :link, :as => :url
      elements :item, :as => :entries, :class => EnxtDMNEntry

      attr_accessor :feed_url

      def self.able_to_parse?(xml) #:nodoc:
        (/<description>.*Dallas Morning News.*<\/description>/m =~ xml)
      end
    end

  end

end
