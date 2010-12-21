class NhsController < ApplicationController
  
  def index
    # @zip = params[:zip]
    # @distance = params[:distance]
    # # if @zip && @distance
    # #   meters = @distance.to_i * 609.344
    # #   @geo=MultiGeocoder.geocode(@zip)
    # #   @zoom = calculate_zoom_level(meters)
    # #   @homes = Home.find(:all, :conditions=>"location is not null and st_distance(location, ST_GeogFromText('SRID=4326;POINT(#{@geo.lng} #{@geo.lat})')) < #{meters}")
    # # end
  end
  
  def search
    @zip = params[:zip]
    @max = params[:max]
    @geo = Geokit::Geocoders::GoogleGeocoder.geocode(@zip)
    ActiveRecord::Base.connection.execute("set @latitude=#{@geo.lat};")
    ActiveRecord::Base.connection.execute("set @longitude=#{@geo.lng};")
    @homes = Home.find_by_sql(sql_command(@geo, @max))
    
    # @homes = Home.find(:all, :include=>:location).reject{|h| h.location.blank?}.each{|h| h.distance_from = h.location.distance(loc) }.sort{|x, y| x.distance_from <=> y.distance_from}
    # @homes = @homes[0..@max.to_i]
    # str = "1478, 1485, 1399, 1489, 1438, 1338, 1535, 1526, 1450, 1372, 1466"
    # @homes = Home.find(:all, :conditions => "id in (#{str})")

    max_distance = @homes.first.location.distance(@homes.last.location)
    @zoom = calculate_zoom_level(max_distance * 620) # we're in kilometers here

    render(:action=>:index)    
  end
  
  private
  
  def sql_command(geo, limit)
    sql = "SELECT homes.*, 3956 * 2 * ASIN(SQRT(POWER(SIN((@latitude - ABS(locations.latitude)) * pi()/180 / 2), 2) + COS(@latitude * pi()/180 ) * COS(ABS(locations.latitude) * pi()/180) * POWER(SIN((@longitude - locations.longitude) * pi()/180 / 2), 2))) as distance FROM homes inner join locations on homes.id = locations.home_id ORDER BY distance limit #{limit};"
    sql
  end
  
  
  # from google's scale estimates (depends a bit)
  def calculate_zoom_level(miles)
    result = case miles
      when 0..39 then 19
      when 40..77 then 18
      when 78..154 then 17
      when 155..307 then 16
      when 308..614 then 15
      when 615..1227 then 14
      when 1228..2453 then 13
      when 2454..4910 then 12
      when 4911..9809 then 11
      when 9810..19618 then 10
      when 19619..39235 then 9
      when 39235..78469 then 8
      when 78470..156938 then 7
      when 156939..313876 then 6
      when 313877..627751 then 5
      when 627752..1255501 then 4
      when 1255502..2511001 then 3
      when 2511002..5022001 then 2
      when 5022002..10044001 then 1
      when 10044002..10000000000000 then 0
    end
  end
  
  
end
