require_relative 'spec_helper'

describe 'rsc-nginx::collectd' do

  before do
    stub_command('which nginx').and_return(nil)
  end

  let(:chef_run) do
    ChefSpec::Runner.new do |node|
    end.converge(described_recipe)
  end

  context 'it will install the nginx chef plugin' do

    it 'will install chef rewind' do
      expect(chef_run).to install_chef_gem('chef-rewind')
    end

    it 'will include collectd::default' do
      expect(chef_run).to include_recipe('collectd::default')
    end
  end
end
