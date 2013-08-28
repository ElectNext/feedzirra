module Feedzirra

  module Parser
    # Parser for dealing with RDF feed entries.
    class EnxtRCPEntry
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

      # for RCP, this is the only pub date field we want to consider
      element :pubDate, :as => :published

      element :"dcterms:modified", :as => :updated
      elements :category, :as => :categories
      
      element :guid, :as => :entry_id     
    end

  end

end
