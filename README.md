Timeshifter
===========

## DESCRIPTION

Timeshifter is a library for shifting time around within a day. You can set
valid hour ranges and Timeshifter will spread a time out within those ranges.

For example, say your valid ranges are outside business hours (midnight until
9am and 5pm until midnight). You can set those as your valid ranges and shift
your time within those ranges:

	# Create a shifter for 12am-9am, 5pm-12am
	shifter = Timeshifter.new([0..9, 17..24])
	shifter.total_hours  # => 16
	shifter.shift(Time.utc(2010, 1, 1, 0, 0, 0))     # => "Fri Jan 01 00:00:00 UTC 2010"
	shifter.shift(Time.utc(2010, 1, 1, 12, 0, 0))    # => "Fri Jan 01 08:00:00 UTC 2010"
	shifter.shift(Time.utc(2010, 1, 1, 18, 0, 0))    # => "Fri Jan 01 20:00:00 UTC 2010"
	shifter.shift(Time.utc(2010, 1, 1, 23, 59, 59))  # => "Fri Jan 01 23:59:59 UTC 2010"

Timeshifter follows the rules of [Semantic Versioning](http://semver.org/) and
uses [TomDoc](http://tomdoc.org/) for inline documentation.


## CONTRIBUTE

Have a great idea for Timeshifter? Awesome. Fork the repository and add a
feature or fix a bug. There are a couple things I ask:

1. You must have tests for all code you check in.
1. Create an appropriately named topic branch that contains your change.