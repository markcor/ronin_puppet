require 'master_manipulator'

test_name 'FM-3918 - C95873 - Create /etc/motd file with content parameter'

pp = <<-PUPPETCODE
  class { 'motd':
    content => 'Hello, this is the /etc/motd file content generated by a beaker test\n',
  }
  include motd
PUPPETCODE

step 'Inject "site.pp" on Master'
site_pp = create_site_pp(master, manifest: pp)
inject_site_pp(master, get_site_pp_path(master), site_pp)

step 'Run Puppet Agent to apply the above manifest'
confine_block(:except, roles: ['master', 'dashboard', 'database']) do
  agents.each do |agent|
    on(agent, puppet('agent -t --environment production'), acceptable_exit_codes: [0, 2]) do |result|
      assert_no_match(%r{Error:}, result.stderr, 'Unexpected error was detected!')
    end
    step 'Verify the content of motd file:'
    next unless fact_on(agent, 'osfamily') != 'Windows'
    file_content = on(agent, 'cat /etc/motd').stdout.strip
    if file_content != 'Hello, this is the /etc/motd file content generated by a beaker test'
      fail_test '/etc/motd file content is empty or mismatch'
    end
  end
end
