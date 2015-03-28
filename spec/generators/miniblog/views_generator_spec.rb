require 'spec_helper'

describe Miniblog::ViewsGenerator do
  let(:destination) { 'tmp' }

  before do
    FileUtils.rm_rf 'tmp'
  end

  it "copies all the views" do
    Miniblog::ViewsGenerator.start([], :destination_root => destination)
    Dir['app/views/**/*'].each do |f|
      expect(File.read(f)).to eq File.read(File.join(destination, f)) unless File.directory?(f)
    end
  end
end
