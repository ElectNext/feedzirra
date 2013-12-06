# coding: utf-8
require File.join(File.dirname(__FILE__), %w[.. .. spec_helper])

describe Feedzirra::Parser::EnxtDMNEntry do
  context "Main site feed" do
    before(:each) do
      @entry = Feedzirra::Parser::EnxtDMN.parse(sample_enxt_dmn_feed).entries.first
    end

    it "should parse the title" do
      @entry.title.should == "Editorial: Resolve the fracking-earthquake debate"
    end

    it "should parse the url" do
      @entry.url.strip.should == "http://www.dallasnews.com/opinion/editorials/20131205-editorial-resolve-the-fracking-earthquake-debate.ece"
    end

    it "should parse the published date" do
      @entry.published.should == Time.parse_safely("Thu, 05 Dec 2013 20:50:41 CST")
    end

    it "should parse the articleID as id" do
      @entry.id.should == "1330206"
    end
    #
    it "should support each" do
      @entry.respond_to? :each
    end

    it "should be able to list out all fields with each" do
      all_fields = []
      @entry.each do |field, value|
        all_fields << field
      end
      all_fields.sort == ['author', 'categories', 'content', 'id', 'published', 'summary', 'title', 'url']
    end

    it "should be able to list out all values with each" do
      title_value = ''
      @entry.each do |field, value|
        title_value = value if field == 'title'
      end
      title_value.should == "Editorial: Resolve the fracking-earthquake debate"
    end

    it "should support checking if a field exists in the entry" do
      @entry.include?('title') && @entry.include?('author')
    end

    it "should allow access to fields with hash syntax" do
      @entry['title'] == @entry.title
      @entry['title'].should == "Editorial: Resolve the fracking-earthquake debate"
      @entry['author'] == @entry.author
      @entry['author'].should == "Dallas Morning News Staff"
    end

    it "should allow setting field values with hash syntax" do
      @entry['title'] = "Foobar"
      @entry.title.should == "Foobar"
    end
  end

  context "Blog feed" do
    before(:each) do
      @entry = Feedzirra::Parser::EnxtDMN.parse(sample_enxt_dmn_blog_feed).entries.first
    end

    it "should parse the title" do
      @entry.title.strip.should == "Dallas County races take shape as filing deadline looms"
    end

    it "should parse the url" do
      @entry.url.strip.should == "http://trailblazersblog.dallasnews.com/2013/12/dallas-county-races-take-shape-as-filing-deadline-looms.html/"
    end

    it "should parse the published date" do
      @entry.published.should == Time.parse_safely("Thu, 05 Dec 2013 22:44:29 +0000")
    end

    it "should parse the articleID as id" do
      @entry.id.should == "trail-blazers-blog-35824"
    end

    it "should support each" do
      @entry.respond_to? :each
    end

    it "should be able to list out all fields with each" do
      all_fields = []
      @entry.each do |field, value|
        all_fields << field
      end
      all_fields.sort == ['author', 'categories', 'content', 'id', 'published', 'summary', 'title', 'url']
    end

    it "should be able to list out all values with each" do
      title_value = ''
      @entry.each do |field, value|
        title_value = value if field == 'title'
      end
      title_value.strip.should == "Dallas County races take shape as filing deadline looms"
    end

    it "should support checking if a field exists in the entry" do
      @entry.include?('title') && @entry.include?('author')
    end

    it "should allow access to fields with hash syntax" do
      @entry['title'] == @entry.title
      @entry['title'].strip.should == "Dallas County races take shape as filing deadline looms"
      @entry['url'] == @entry.url
      @entry['url'].strip.should == "http://trailblazersblog.dallasnews.com/2013/12/dallas-county-races-take-shape-as-filing-deadline-looms.html/"
    end

    it "should allow setting field values with hash syntax" do
      @entry['title'] = "Foobar"
      @entry.title.should == "Foobar"
    end
  end
end
