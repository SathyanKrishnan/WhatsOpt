require 'test_helper'

class SolverTest < ActiveSupport::TestCase
  
  test "should be created solver with defaults" do
    solver = Solver.new
    assert_equal 1e-10, solver.atol
    assert_equal 1e-10, solver.rtol
    assert_equal 10, solver.maxiter
    assert_equal 1, solver.iprint
    assert_equal true, solver.err_on_maxiter
  end

end