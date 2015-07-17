require_relative 'spec_helper'

describe 'rsc-nginx::tags' do

  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set['rsc-nginx']['application_name'] = 'default'
      node.set['cloud']['private_ips'] = [ '10.0.0.1' ]
    end.converge(described_recipe)
  end

  context 'setting tags' do
    it 'will include rightscale_tag recipe' do
      expect(chef_run).to include_recipe('rightscale_tag::default')
    end

    it 'will setup application tags' do
      expect(chef_run).to create_rightscale_tag_application(chef_run.node['rsc-nginx']['application_name'])
    end
  end

end
