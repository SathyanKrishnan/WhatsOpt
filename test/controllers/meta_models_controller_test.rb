# frozen_string_literal: true

require "test_helper"

class MetaModelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mda = analyses(:cicav)
    @ope = operations(:doe)
    @user = users(:user1)
    sign_in @user
  end

  teardown do
    WhatsOpt::SurrogateProxy.shutdown_server
  end

  test "should create a metamodel" do
    assert_difference("Analysis.count", 1) do
      assert_difference("MetaModel.count", 1) do
        assert_difference("Surrogate.count", 1) do
          post operation_meta_models_url(@ope), params: {meta_model: {kind: Surrogate::SURROGATES[1]}}
        end
      end
    end

    mda = Analysis.last
    assert_equal 2, mda.design_variables.count
    assert_equal 1, mda.response_variables.count
    x1 = mda.design_variables.first
    assert_equal "1", x1.parameter.lower
    assert_equal "10", x1.parameter.upper
    z = mda.design_variables.second
    assert_equal "1", z.parameter.lower
    assert_equal "10", z.parameter.upper
    assert_equal 1, mda.response_variables.count
    mm = MetaModel.last
    assert_equal @ope, mm.operation
    assert_equal mda.disciplines.last, mm.discipline
    assert_equal Surrogate::SURROGATES[1], mm.default_surrogate_kind
    assert_equal 1, mm.surrogates.count
    surr = Surrogate.last
    assert_equal surr, mm.surrogates.first
    assert_equal mm.default_surrogate_kind, surr.kind
    assert_equal -1, surr.coord_index  # obj is a scalar
    assert_equal @user, mm.discipline.analysis.owner
  end

  test "should take into account variables selection" do
    post operation_meta_models_url(@ope), params: {
      meta_model: {kind: Surrogate::SURROGATES[0], variables: {inputs: ['x1'], outputs: ['obj']} }
    }
    mda = Analysis.last
    assert_equal 1, mda.design_variables.count
    assert_equal 1, mda.response_variables.count
  end

end