require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Rapper do
  describe "setup" do
    it "loads configuration and environment" do
      lambda do
        Rapper.setup( "spec/fixtures/config/assets.yml", "test" )
      end.should_not raise_error
    end
    
    it "bombs out if given a bad configuration file" do
      lambda do
        Rapper.setup( "spec/fixtures/config/fake.yml", "test" )
      end.should raise_error( Errno::ENOENT )
    end
    
    it "bombs out if given an undefined environment" do
      lambda do
        Rapper.setup( "spec/fixtures/config/assets.yml", "error" )
      end.should raise_error( Rapper::Errors::InvalidEnvironment )
    end
    
    it "uses the given environment's specific config" do
      Rapper.setup( "spec/fixtures/config/assets.yml", "test" )
      Rapper.environment.should == "test"
      # private
      Rapper.env_config["bundle"].should be_true
      Rapper.env_config["compress"].should be_true
      Rapper.env_config["version"].should be_false
    end
    
    it "loads asset definitions"
  end
  
  describe "logging" do
    it "is off by default"
    it "can log to stdout"
    it "can log to a file"
  end
  
  describe "bundling" do
    it "can be turned off"
    it "concatenates files"
  end
  
  describe "compressing" do
    it "can be turned off"
    it "compresses, if configured to"
  end
end

describe YUI::CSSCompressor do
  # Originally from: https://github.com/rhulse/ruby-css-toolkit/blob/master/test/yui_compressor_test.rb
  test_files = Dir[File.join( File.dirname( __FILE__ ), '/fixtures/yui_css/*.css' )]
  test_files.each_with_index do |file, i|
    test_css = File.read(file)
    expected_css = File.read( file + '.min' )
    test_name = File.basename( file, ".css" )
    
    it "passes #{test_name} test" do
      YUI::CSSCompressor.compress( test_css ).should == expected_css
    end
  end
end
