class Deficiency < ActiveRecord::Base
  belongs_to :survey
  belongs_to :home
  
  def weight

    severityX = case self.severity
      when "B" then 1.2
      when "C" then 1.4
      when "D" then 1.6
      when "E" then 1.8
      when "F" then 2.0
      when "G" then 2.2
      when "H" then 2.4
      when "I" then 2.6
      when "J" then 2.8
      when "K" then 3.0
      when "L" then 3.2
    end

    scopeX = case self.scope
      when "Isolated" then 1
      when "Widespread" then 2
      when "Pattern" then 3
    end

    return severityX * scopeX
  end
end
