lib = File.expand_path('../lib', File.dirname(__FILE__))
$:.unshift lib unless $:.include?(lib)

require 'timeshifter/version'

class Timeshifter
  ##############################################################################
  #
  # Constructor
  #
  ##############################################################################
  
  # Initializes an object that will shift time within a valid set of ranges.
  #
  # ranges - A list of ranges to shift time within.
  def initialize(ranges)
    raise "Ranges are required" if ranges.nil?
    @ranges = ranges.compact.sort {|x,y| x.begin <=> y.begin}
  end
  

  ##############################################################################
  #
  # Properties
  #
  ##############################################################################

  # The list of valid ranges.
  def ranges
    Array.new(@ranges)
  end


  ##############################################################################
  #
  # Methods
  #
  ##############################################################################
  
  # Shifts the time to a valid time in the day based on the ranges provided.
  #
  # time - The time to shift.
  #
  # Returns a time that is within the valid ranges.
  def shift(time)
    return nil if time.nil?
    
    # Check if it's UTC
    is_utc = time.utc?
    
    # Determine the total available seconds from the ranges.
    tsec = (total_hours * 3600).to_f
    raise "No hours available to shift within" if tsec == 0
    
    # Determine original seconds in time for the day
    osec = ((time.hour*3600) + (time.min*60) + time.sec).to_f

    # Determine time shifted seconds in time for the day
    sec  = osec * (tsec/86400)
    
    # Work through ranges and compact time
    current = 0.0
    ranges.each do |range|
      rsec = ((range.end - range.begin) * 3600).to_f
      
      # If time time is within this range calculate the position
      if sec < current+rsec
        shifted_time = Time.at(time.to_i - osec.to_i + (range.begin*3600)+(sec-current).to_i)

        # Return UTC if that's what was passed in
        if is_utc
          shifted_time = shifted_time.getutc()
        end
        
        return shifted_time
      end

      # Add range second total to current seconds
      current += rsec
    end
    
    # We should have been able to shift within a range by now
    raise "Time could not be shifted inside range: #{osec} #{sec} #{current}"
  end
  
  # Calculates the total hours available based on the ranges provided.
  def total_hours
    total = 0

    # Calculate total
    ranges.each do |range|
      total += range.end - range.begin
    end
    
    return total
  end
end
