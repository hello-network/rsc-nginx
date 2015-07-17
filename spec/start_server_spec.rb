require_relative 'spec_helper'

describe 'rsc-nginx::start_server' do

  let(:chef_run) do
    ChefSpec::Runner.new do |node|
    end.converge(described_recipe)
  end

  context 'starts nginx' do
    it 'will start nginx server' do
      expect(chef_run).to start_service('nginx')
    end
  end

end
