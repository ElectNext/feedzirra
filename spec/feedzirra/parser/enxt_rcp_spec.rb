require File.join(File.dirname(__FILE__), %w[.. .. spec_helper])

describe Feedzirra::Parser::EnxtRCP do
  describe "#will_parse?" do
    it "should return true for an RCP feed" do
      Feedzirra::Parser::EnxtRCP.should be_able_to_parse(sample_enxt_rcp_feed)
    end

    # This is known behavior, since RCP is an RSS feed.
    # The order the feeds are listed in Feed.feed_classes is important
    it "should return true for an RSS feed" do
      Feedzirra::Parser::EnxtRCP.should_not be_able_to_parse(sample_rss_feed)
    end

    it "should return false for an atom feed" do
      Feedzirra::Parser::EnxtRCP.should_not be_able_to_parse(sample_atom_feed)
    end

    it "should return false for an rss feedburner feed" do
      Feedzirra::Parser::EnxtRCP.should_not be_able_to_parse(sample_rss_feed_burner_feed)
    end
  end

  describe "parsing" do
    before(:each) do
      @feed = Feedzirra::Parser::EnxtRCP.parse(sample_enxt_rcp_feed)
    end
    
    it "should parse the title" do
      @feed.title.should == "RealClearPolitics - Articles"
    end

    it "should parse the description" do
      @feed.description.should be_nil
    end

    it "should parse the url" do
      @feed.url.should == "http://www.realclearpolitics.com/"
    end
    
    it "should provide an accessor for the feed_url" do
      @feed.respond_to?(:feed_url).should == true
      @feed.respond_to?(:feed_url=).should == true
    end
    
    it "should parse entries" do
      @feed.entries.size.should == 50
    end
  end
end