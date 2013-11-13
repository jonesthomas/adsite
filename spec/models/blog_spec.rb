require 'spec_helper'

describe Blog do
	  before { @blog = Blog.new(title: "First Blog", body: "a*1000") }

  subject { @blog }

  it { should respond_to(:title) }
  it { should respond_to(:body) }

 	describe "when title is not present" do
    before { @blog.title = " " }
    it { should_not be_valid }
  end


 	describe "when body is not present" do
    before { @blog.body = " " }
    it { should_not be_valid }
  end

	describe "when title is too long " do
		before  {@blog.title="a" *141 } 
		it {should_not be_valid}
	end # title is too long

	describe "when body is too long " do
		before  {@blog.title="a" *10001 } 
		it {should_not be_valid}
	end # body is too long
end # end the blog
