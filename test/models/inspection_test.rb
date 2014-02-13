require 'test_helper'

class InspectionTest < ActiveSupport::TestCase

  test "Create a invalid inspection" do
   	inspection = Inspection.new
   	assert !inspection.save, "Saved without information"
  end
end