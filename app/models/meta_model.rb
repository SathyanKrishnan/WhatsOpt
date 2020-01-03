# frozen_string_literal: true

require "matrix"

class MetaModel < ApplicationRecord
  belongs_to :discipline
  belongs_to :operation

  has_many :surrogates, dependent: :destroy

  validates :discipline, presence: true

  after_initialize :_set_defaults
  before_destroy :_destroy_related_operation

  MATRIX_FORMAT = "matrix"
  FORMATS = [MATRIX_FORMAT]

  class PredictionError < StandardError; end

  def analysis
    discipline.analysis  # a metamodel a no existence out of analysis context
  end

  def build_surrogates
    analysis.response_variables.each do |v|
      (0...v.dim).each do |index|
        surrogates.build(variable: v, coord_index: index-1, kind: default_surrogate_kind)
      end
    end
  end

  def build_copy(discipline=nil, operation=nil)
    mm_copy = self.dup
    mm_copy.discipline = discipline if discipline
    mm_copy.operation = operation if operation
    self.surrogates.each do |surr|
      var = discipline.variables.detect{|v| v.name == surr.variable.name} if discipline
      surr_copy = surr.build_copy(mm_copy, var)
    end
    mm_copy
  end

  def train(force: true)
    surrogates.each do |surr|
      surr.train if force || !surr.trained?
    end
  end

  def predict(values)
    res = []
    # Convention: values in res corresponds to var names alphabetically sorted
    sorted = surrogates.sort_by { |surr| surr.variable.name }
    names = sorted.map { |surr| surr.variable.name }
    Rails.logger.info "Predict with surrogates of : #{names}"
    sorted.each do |surr|
      yvals = surr.predict(values)
      if res.empty?
        res = yvals.map { |y| [y] }
      else
        yvals.each_with_index do |y, i|
          res[i] << y
        end
      end
    end
    res
  rescue => e
    raise PredictionError.new("Cannot make prediction for #{values}, error: #{e}")
  end

  def training_input_values
    @training_inputs ||= Matrix.columns(operation.input_cases.sort_by { |c| c.label }.map(&:values)).to_a
  end

  def training_output_values(varname, coord_index)
    @training_outputs ||= operation.output_cases
                            .detect {|c| c.variable.name == varname && c.coord_index == coord_index}.values
  end

  def qualification
    surrogates.map(&:qualify)
  end

private
  def _set_defaults
    self.default_surrogate_kind = Surrogate::SMT_KRIGING if self.default_surrogate_kind.blank?
  end

  def _destroy_related_operation
    self.operation.destroy! if operation
  end
end
