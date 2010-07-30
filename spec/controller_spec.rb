require 'spec_helper'
describe Controller do
  describe 'when no input file has been selected yet' do
    it 'should not have a "go" button'
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
