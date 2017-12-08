require 'spec_helper_acceptance'
# Tests for class bind
describe 'bind', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'should work with no errors' do
    result = apply_manifest(example('init.pp'), catch_failures: true)
    expect(result.exit_code).to be(2)
  end

  it 'should work idempotently' do
    apply_manifest(example('init.pp'), catch_changes: true)
  end
end
