class Shoes
  # accept any 'ole thing
  def method_missing(*args, &block)
  end
  @@the_shoes = nil
  class << self
    def app(&block)
      the_shoes.instance_eval(&block) if block_given? 
    end
    def the_shoes
      @@the_shoes ||= new
    end
  end
end
require 'spec_helper'
describe 'sermonator gui' do
  describe 'when no input file has been selected yet' do
    before do
      @shoes = Shoes.the_shoes
      @shoes.stub(:button)
    end
    it 'should not have a "go" button' do
      @shoes.should_receive(:button).with('go').never
      require 'spec_helper'
    end
    it 'should have a "select file" button' do
      @shoes.should_receive(:button).with('select file')
    end
    after do
      eval File.open("#{File.dirname(__FILE__)}/../lib/controller.rb").read
    end
  end
  describe 'when an incompatable file is selected' do
    it 'should display an error'
    it 'should not have a "go" button'
  end
  describe 'when a compatable file is selected' do
    it 'should have a go button'
    it 'should display the file name'
    describe 'when the go button is pressed' do
      it 'should say "converting"'
      it 'should not have a "go" button'
      it 'should have a "cancel" button'
      it 'should convert the file'
      describe 'when the file is successfully converted to a stream' do
        it 'should say "uploading"'
        it 'should not say "converting"'
        it 'should upload the file to the configured server'
        describe 'when the file fails to be uploaded' do
          it 'should display an error'
        end
        describe 'when the file is successfully uploaded' do
          it 'should not say "uploading"'
          it 'should say "posting"'
          it 'should create the blog post'
          describe 'when the post is created' do
            it 'should say "I feel I did well!"'
            it 'should display a link to the new post'
            it 'should check the podcast feed'
          end
          describe 'when the post cannot be created' do
            it 'should display an error'
          end
        end
      end
      describe 'when the file is not converted to a stream' do
        it 'should display an error'
      end
    end
  end
end
