require File.join(File.dirname(__FILE__), %w[.. .. spec_helper])

describe Feedzirra::Parser::EnxtDMN do
  context "Main Site Feed" do
    describe "#will_parse?" do
      it "should return true for an DMN feed" do
        Feedzirra::Parser::EnxtDMN.should be_able_to_parse(sample_enxt_dmn_feed)
      end

      it "should return false for an atom feed" do
        Feedzirra::Parser::EnxtDMN.should_not be_able_to_parse(sample_atom_feed)
      end

      it "should return false for an rss feedburner feed" do
        Feedzirra::Parser::EnxtDMN.should_not be_able_to_parse(sample_rss_feed_burner_feed)
      end
    end

    describe "parsing" do
      before(:each) do
        @feed = Feedzirra::Parser::EnxtDMN.parse(sample_enxt_dmn_feed)
      end

      it "should parse the title" do
        @feed.title.should == "Dallas Morning News - Opinion"
      end

      it "should parse the description" do
        @feed.description.should == "The RSS feed of The Dallas Morning News"
      end

      it "should parse the url" do
        @feed.url.should == "http://www.dallasnews.com/opinion/"
      end

      it "should provide an accessor for the feed_url" do
        @feed.respond_to?(:feed_url).should == true
        @feed.respond_to?(:feed_url=).should == true
      end

      it "should parse entries" do
        @feed.entries.size.should == 15
      end
    end
  end

  context "blog feed" do
    describe "#will_parse?" do
      it "should return true for an DMN feed" do
        Feedzirra::Parser::EnxtDMN.should be_able_to_parse(sample_enxt_dmn_blog_feed)
      end

      it "should return false for an atom feed" do
        Feedzirra::Parser::EnxtDMN.should_not be_able_to_parse(sample_atom_feed)
      end

      it "should return false for an rss feedburner feed" do
        Feedzirra::Parser::EnxtDMN.should_not be_able_to_parse(sample_rss_feed_burner_feed)
      end
    end

    describe "parsing DMN feed" do
      before(:each) do
        @feed = Feedzirra::Parser::EnxtDMN.parse(sample_enxt_dmn_blog_feed)
      end

      it "should parse the title" do
        @feed.title.should == "Trail Blazers Blog"
      end

      it "should parse the description" do
        @feed.description.strip.should == "The blog for the Dallas Morning News politics team tracks Dallas area, Texas and national campaigns."
      end

      it "should parse the url" do
        @feed.url.should == "http://trailblazersblog.dallasnews.com"
      end

      it "should provide an accessor for the feed_url" do
        @feed.respond_to?(:feed_url).should == true
        @feed.respond_to?(:feed_url=).should == true
      end

      it "should parse entries" do
        @feed.entries.size.should == 20
      end
    end
  end
end
