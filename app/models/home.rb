class Home < ActiveRecord::Base
  has_one :location
  has_one :facility
  has_many :surveys
  has_many :deficiencies, :through => :surveys

  attr_accessor :distance_from

  def address_to_s
    "#{self.street}, #{self.city}, #{self.state}, #{self.zip}"
  end

  def save_location(force=false)
    return if !self.location.blank? && !force
    geo = Geokit::Geocoders::GoogleGeocoder.geocode(self.address_to_s)
    if (geo.lat.blank? || geo.lng.blank?)
      p "Could not find location for home: #{self.id} - #{self.address_to_s}"
    else
      self.location = Location.new(:latitude => geo.lat, :longitude => geo.lng)
      self.save
    end
    
  end


end
