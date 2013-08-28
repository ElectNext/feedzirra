module Feedzirra

  module Parser
    # Parser for dealing with RSS feeds.
    class EnxtRCP
      include SAXMachine
      include FeedUtilities
      element :title
      element :description
      element :link, :as => :url
      elements :item, :as => :entries, :class => EnxtRCPEntry

      attr_accessor :feed_url

      def self.able_to_parse?(xml)
        (/<title>RealClearPolitics - Articles<\/title>/ =~ xml)
      end
    end
  end
end