require 'spec_helper_acceptance'

# Tests for define bind::server::conf
describe 'bind::server::conf', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  let(:download_pp) { example('bind::server::conf') }

  it 'should work with no errors' do
    result = apply_manifest(download_pp, catch_failures: true)
    expect(result.exit_code).to be(2)
  end
  it 'should work idempotently' do
    apply_manifest(download_pp, catch_changes: true)
  end
  describe file('/etc/named.conf') do
    it { is_expected.to exist }
    it { is_expected.to contain 'acl' }
  end
end
