require 'chefspec'
begin require 'chefspec/deprecations'; rescue LoadError; end

describe 'dotfiles::default' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path)
  end

  let(:chef_run) do
    chef_runner.converge 'dotfiles::default'
  end
  
  it 'requires git' do
    expect(chef_run).to include_recipe 'git'
  end
  
  it 'creates dotfiles directory' do
    chef_runner.node.set['dotfiles']['users'] = {
      'foo-0815' => {
        'repo' => 'git@example.org:dotfiles.git'
      },
      'bar-0815' => {
        'repo' => 'git@example.com:dotfiles.git'
      }
    }
    chef_runner.node.set['etc']['passwd']['foo-0815']['dir'] = '/home/foo'
    chef_runner.node.set['etc']['passwd']['bar-0815']['dir'] = '/not-in-home/bar'
    chef_run = chef_runner.converge 'dotfiles::default'
    expect(chef_run).to create_directory '/home/foo/dotfiles'
    expect(chef_run).to create_directory '/not-in-home/bar/dotfiles'
  end
  
  it 'executes configure.sh' do
    chef_runner.node.set['dotfiles']['users'] = {
      'foo-0815' => {
        'repo' => 'git@example.org:dotfiles.git'
      }
    }
    chef_runner.node.set['etc']['passwd']['foo-0815']['dir'] = '/home/foo'
    chef_run = chef_runner.converge 'dotfiles::default'
    expect(chef_run).to execute_command 'sudo -H -u foo-0815 /home/foo/dotfiles/configure.sh'
  end
end
