require 'rspec/bash'

describe 'n8l::default_eups_pkgroot' do
  include Rspec::Bash

  let(:stubbed_env) { create_stubbed_env }
  subject(:func) { 'n8l::default_eups_pkgroot' }

  # this function is extremely difficult to test as it uses n8l::sys::*
  # functions, which return values by setting env vars.  Only the 'src' pkgroot
  # may be function tested.
  it 'returns default src pkgroot' do
    out, err, status = stubbed_env.execute_function(
      'scripts/newinstall.sh',
      func,
    )

    expect(status.exitstatus).to be 0
    expect(out).to match(%r{https://eups.lsst.codes/stack/src})
    expect(err).to eq('')
  end

  it 'returns default src pkgroot' do
    out, err, status = stubbed_env.execute_function(
      'scripts/newinstall.sh',
      "#{func} true",
    )

    expect(status.exitstatus).to be 0
    expect(out).to match(%r{https://eups.lsst.codes/stack/src})
    expect(err).to eq('')
  end

  it 'does not return the default src pkgroot' do
    out, err, status = stubbed_env.execute_function(
      'scripts/newinstall.sh',
      "#{func} false",
    )

    expect(status.exitstatus).to be 0
    expect(out).to eq('')
    expect(err).to eq('')
  end
end
