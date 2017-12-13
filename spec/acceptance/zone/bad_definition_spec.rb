require 'spec_helper_acceptance'
# Tests for define flyway::migrate
describe 'bind::zone::bad_definition', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  let(:pp) { example('bind::zone::bad_definition') }

  it 'should work with errors' do
    apply_manifest(pp, expect_failures: true)
  end
end
