class NhsController < ApplicationController
  
  def show
    @zip = params[:zip]
    @distance = params[:distance]
    # if @zip && @distance
    #   meters = @distance.to_i * 609.344
    #   @geo=MultiGeocoder.geocode(@zip)
    #   @zoom = calculate_zoom_level(meters)
    #   @homes = Home.find(:all, :conditions=>"location is not null and st_distance(location, ST_GeogFromText('SRID=4326;POINT(#{@geo.lng} #{@geo.lat})')) < #{meters}")
    # end
  end
  
  private
  
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
