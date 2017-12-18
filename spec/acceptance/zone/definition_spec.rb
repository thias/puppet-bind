require 'spec_helper_acceptance'
# Tests for define flyway::migrate
describe 'bind::zone::definition', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  let(:pp) { example('bind::zone::definition') }

  it 'should work with no errors' do
    result = apply_manifest(pp, catch_failures: true)
    expect(result.exit_code).to be(2)
  end
  it 'should work idempotently' do
    apply_manifest(pp, catch_changes: true)
  end
  describe file('/var/named/test_file.com') do
  it { should exist }
   it { should contain 'world.dev.internal' }
  end
  describe file('/etc/named.conf') do
  it { should exist }
  it { should contain '/var/named/test_file.com' }
  end
end
