module Feedzirra

  module Parser
    # Parser for dealing with RDF feed entries.
    class EnxtDMNEntry
      include SAXMachine
      include FeedEntryUtilities

      element :title
      element :link, :as => :url
      
      element :"dc:creator", :as => :author
      element :author, :as => :author
      element :"content:encoded", :as => :content
      element :description, :as => :summary

      element :"media:content", :as => :image, :value => :url
      element :enclosure, :as => :image, :value => :url
      
      element :pubDate, :as => :published
      element :pubdate, :as => :published
      element :"dc:date", :as => :published
      element :"dc:Date", :as => :published
      element :"dcterms:created", :as => :published
      
      
      element :"dcterms:modified", :as => :updated
      element :issued, :as => :published
      elements :category, :as => :categories

      # articleID is the custom DMN field for their main site feeds
      element :articleID, :as => :entry_id

      # we still want guid, as it's the field in the blog feed entries
      element :guid, :as => :entry_id

      # the above order for guid vs. articleID doesn't seem to matter:
      # by default guid always wins. So this is a custom setter for
      # entry_id, If the value is numeric (which means it came from
      # articleID), then keep that.
      def entry_id=(val)
        @entry_id.to_i != 0 || (@entry_id = val)
      end
    end
  end

end
