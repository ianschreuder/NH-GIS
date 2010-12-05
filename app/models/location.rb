class Location < ActiveRecord::Base
  belongs_to :home
  
  def distance(other)
    return nil unless self.latitude && self.longitude && other.latitude && other.longitude
    radius = 6371; # (km)
    d_lat = (other.latitude - self.latitude).degrees
    d_lng = (other.longitude - self.longitude).degrees
    a = Math.sin(d_lat/2.0)*Math.sin(d_lat/2.0) + Math.cos(self.latitude.degrees)*Math.cos(other.latitude.degrees)*Math.sin(d_lng/2.0)*Math.sin(d_lng/2.0)
    c = 2*Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    d = radius * c
    return d
  end
  

end

