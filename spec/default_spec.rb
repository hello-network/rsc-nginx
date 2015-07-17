require_relative 'spec_helper'

describe 'rsc-nginx::default' do

  before do
    stub_command('which nginx').and_return(nil)
  end

  let(:chef_run) do
    ChefSpec::Runner.new do |node|
    end.converge(described_recipe)
  end

  context 'sets up default attributes and runs' do
    it 'will include nginx::default' do
      expect(chef_run).to include_recipe('nginx::default')
    end
  end

end
