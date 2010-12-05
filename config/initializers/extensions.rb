class Numeric
  def round(digits); x=10**digits; num = self*x; num = num.round; return (num/=x.to_f); end
  def degrees(); self * Math::PI / 180; end
end

class Array
  def mean() (sum / size.to_f); end
end
