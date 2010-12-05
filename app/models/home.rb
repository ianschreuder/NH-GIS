class Home < ActiveRecord::Base
  has_one :location
  has_one :facility
  has_many :surveys
  has_many :deficiencies, :through => :surveys



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


  # Google was unable to geocode address: 439 DANBURY RD RT 7, WILTON, CT, 06897
  # Google was unable to geocode address: 310 S0UTH BAKER STREET, ALMA, GA, 31510
  # Google was unable to geocode address: 7951 E P TRUE PARKWAY, WEST DES MOINES, IA, 50266
  # Google was unable to geocode address: 520 W MAIN ST C/O BOX 206, NORTHVILLE, MI, 48167
  # Google was unable to geocode address: 100 MAZADABROOK ROAD, PARSIPPANY TROY HILL, NJ, 07054
  # Google was unable to geocode address: 300 HOLLINSHEAD SPRING ROAD, SKILLMAN, NJ, 08558
  # Google was unable to geocode address: 200 FLOWER-PRIDGEN DR, WHITEVILLE, NC, 28472
  # Google was unable to geocode address: 2274 MCDERMOTT POND CREEK ROAD, MCDERMOTT, OH, 45652
  # Google was unable to geocode address: BOX 100, KENNETT SQUARE, PA, 19348
  # Google was unable to geocode address: MSC 250 WINSTON CHURCHIL AVE 138, RIO PIEDRAS, PR, 00926
  # Google was unable to geocode address: CALLE COSME REPARTO SAN LUCAS SECTOR CANEJAS, RIO PIEDRAS, PR, 00926
  # Google was unable to geocode address: 400 LOCUST GROVE ROAD, SPARTANBURG, SC, 29303
  # Google was unable to geocode address: 431 LARKIN SPRING RD, MADISON, TN, 37115
  # Google was unable to geocode address: 120 CAVETT HILL LANE, KNOXVILLE, TN, 37922
  # Google was unable to geocode address: 112 RUTH LYNN DR, LONGVIEW, TX, 75605
  # Google was unable to geocode address: 100 COLONNADES HILL DRIVE, CHARLOTTESVILLE, VA, 22901
  # Google was unable to geocode address: 1406 MEDICAL CENTER DRIVE, LEBANON, TN, 37087
  
end
