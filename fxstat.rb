require "csv"

class Dailyfx
  def initialize(d,o,h,l,c)
    @date = d
    @open = o
    @high = h
    @low = l
    @close = c
    @range = (h-l).abs
  end
  attr_accessor :date, :open, :high, :low, :close, :range;
end

def getAverageRange(arr, filter)
  i = 0
  sum = 0.0

  #year range
  if filter.length() == 4
    year = filter.to_i()

    #get sum of this year range
    arr.each do |n|
      if n.date.year == year and not n.date.sunday? and not n.date.saturday?
        i = i + 1
        sum = sum + n.range
      end
    end

    return sum/i
  end
end

a = []

CSV.foreach('/Users/rogerji/Documents/gitrepo/fxstat/eu-d.csv', {:headers => true, :header_converters => :symbol, :col_sep => ','}) do |row|
  #d = DateTime.strpitime(row[0], "%m/%d/%Y")
  d = DateTime.parse(row[0])
  a.push(Dailyfx.new(d, row[1].to_f, row[2].to_f, row[3].to_f, row[4].to_f))
end

ya = ['2012', '2011', '2010', '2009', '2008', '2007', '2006', '2005', '2004', '2003', '2002', '2001', '2000']

ya.each { |year| puts year + '   average is   ' + getAverageRange(a, year).to_s }

