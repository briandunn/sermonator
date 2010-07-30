require 'spec_helper'
describe 'Stream' do
  before {pending}
  describe 'creating the stream' do
    before do
      @stream = Stream.new
    end
    describe 'validating settings' do
      describe 'with no settings' do
        it 'should not be valid' do
          @stream.valid?.should be_false
        end
      end
    end
    describe 'with valid settings' do
      it "should use the bit rate it is given" 
      it "should set the id3 title to its title"
      it "should set the artist to its speaker"
      it "should put the date and artist in the file name"
      it "should place the output file in the output directory it is given"
    end
  end
end
