class Survey < ActiveRecord::Base
  has_many :deficiencies
  belongs_to :home
  
  def qis?
    return (self.qis==1) ? true : false
  end
  
  def deficiency_weight
    self.deficiencies.inject(0){|sum, d| sum+=d.weight}
  end

end
