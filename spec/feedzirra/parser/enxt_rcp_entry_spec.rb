# coding: utf-8
require File.join(File.dirname(__FILE__), %w[.. .. spec_helper])

describe Feedzirra::Parser::EnxtRCPEntry do
  before(:each) do
    @entry = Feedzirra::Parser::EnxtRCP.parse(sample_enxt_rcp_feed).entries.first
  end

  after(:each) do
    # We change the title in one or more specs to test []=
    if @entry.title != "Feeling Powerless All Around"
      @entry.title = Feedzirra::Parser::EnxtRCP.parse(sample_enxt_rcp_feed).entries.first.title
    end
  end

  it "should parse the title" do
    @entry.title.should == "Feeling Powerless All Around"
  end

  it "should parse the url" do
    @entry.url.should == "http://www.realclearpolitics.com/articles/2013/08/28/feeling_powerless_all_around_119742.html"
  end

  it "should parse the author" do
    @entry.author.should == "Richard Cohen"
  end

  it "should provide a summary" do
    @entry.summary.should == " The late Katharine Graham was often called one of the most powerful women in the world. You can see why. She controlled The Washington Post, Newsweek, a bevy of television stations and was Washington&apos;s pre-eminent hostess, gathering the influential or the merely interesting in her Georgetown home. Yet she knew her power was severely limited. On a given day, she wouldn&apos;t even dare stop her own newspaper from savaging one of her friends.\nWhat brings this to mind is &quot;The End of Power,&quot; a remarkable new book by the remarkable Moises Naim, the former editor of Foreign Policy...."
  end

  it "should parse the published date" do
    @entry.published.should == Time.parse_safely("Wed, 28 Aug 2013 06:44:56 -0500")
  end

  it "should parse the categories" do
    @entry.categories.should == ["Richard Cohen"]
  end

  it "should parse the guid as id" do
    @entry.id.should == "200119742"
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
    title_value.should == "Feeling Powerless All Around"
  end

  it "should support checking if a field exists in the entry" do
    @entry.include?('title') && @entry.include?('author')
  end

  it "should allow access to fields with hash syntax" do
    @entry['title'] == @entry.title
    @entry['title'].should == "Feeling Powerless All Around"
    @entry['author'] == @entry.author
    @entry['author'].should == "Richard Cohen"
  end

  it "should allow setting field values with hash syntax" do
    @entry['title'] = "Foobar"
    @entry.title.should == "Foobar"
  end
end
