# frozen_string_literal: true

require "whats_opt/csv_case_generator"

class OperationExportsController < ApplicationController
  def new
    @ope = Operation.find(params[:operation_id])
    authorize @ope.analysis
    csvgen = WhatsOpt::CsvCaseGenerator.new
    content, filename = csvgen.generate @ope.sorted_cases, @ope.success
    send_data content, filename: filename
  end
end
