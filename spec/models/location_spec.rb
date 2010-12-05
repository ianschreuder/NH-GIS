require 'spec_helper'

describe Location do
  
  it "should allow us to calculate the distance between two locations" do
    denver = Location.new(:latitude=>39.739154, :longitude=>-104.984703)

    herxheim = Location.new(:latitude=>49.484677, :longitude=>8.476724)
    denver.distance(herxheim).round.should == 8152
    herxheim.distance(denver).round.should == 8152

    buenosaires = Location.new(:latitude=>-34.608418, :longitude=>-58.373161)
    denver.distance(buenosaires).round.should == 9551
    buenosaires.distance(denver).round.should == 9551
  end

  
  
end

