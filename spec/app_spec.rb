# frozen_string_literal: true

require 'spec_helper'

describe 'App' do
  context 'hello route' do
    it 'status is ok' do
      get '/api/v1/hello'
      expect(last_response).to be_ok
    end

    it 'responds with message' do
      get '/api/v1/hello'
      message = JSON.parse(last_response.body)['message']
      expect(message).to eq 'Hello There!!!'
    end
  end
end
