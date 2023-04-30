# frozen_string_literal: true

class SampleWorker
  include Sidekiq::Worker
  def perform
    puts "Started SampleWorker Updated"
    sleep 3
    puts "Completed SampleWorker Updated"
  end
end
