require_relative 'spec_helper'

describe 'rsc-nginx::stop_server' do

  let(:chef_run) do
    ChefSpec::Runner.new do |node|
    end.converge(described_recipe)
  end

  context 'stopping nginx' do
    it 'will stop nginx server' do
      expect(chef_run).to stop_service('nginx')
    end
  end

end
