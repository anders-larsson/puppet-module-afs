require 'spec_helper'
require 'facter/afs_version'

describe 'Facter::Util::AfsVersion (afs_version)' do
  context 'when openafs-1.6.16-1.1 is installed as RPM' do
    it 'returns <1.6.16>' do
      allow(Facter::Util::Resolution).to receive(:exec).with('rpm -q openafs >/dev/null 2>&1 ; echo $?').and_return('0')
      allow(Facter::Util::Resolution).to receive(:exec).with('dpkg-query -W --showformat=\'${version}\' openafs-client >/dev/null 2>&1 ; echo $?').and_return('1')
      allow(Facter::Util::Resolution).to receive(:exec).with('rpm -q --queryformat=\'%{VERSION}\' openafs').and_return('1.6.16')
      expect(Facter::Util::AfsVersion.read_afs_version).to eq('1.6.16')
    end
  end

  context 'when openafs-1.6.2-4.2 is installed as DEB' do
    it 'returns <1.6.2>' do
      allow(Facter::Util::Resolution).to receive(:exec).with('rpm -q openafs >/dev/null 2>&1 ; echo $?').and_return('1')
      allow(Facter::Util::Resolution).to receive(:exec).with('dpkg-query -W --showformat=\'${version}\' openafs-client >/dev/null 2>&1 ; echo $?').and_return('0')
      allow(Facter::Util::Resolution).to receive(:exec).with('dpkg-query -W --showformat=\'${version}\' openafs-client').and_return('1.6.2')
      expect(Facter::Util::AfsVersion.read_afs_version).to eq('1.6.2')
    end
  end

  context 'when openafs is not installed' do
    it 'is undef' do
      allow(Facter::Util::Resolution).to receive(:exec).with('rpm -q openafs >/dev/null 2>&1 ; echo $?').and_return('1')
      allow(Facter::Util::Resolution).to receive(:exec).with('dpkg-query -W --showformat=\'${version}\' openafs-client >/dev/null 2>&1 ; echo $?').and_return('1')
      expect(Facter::Util::AfsVersion.read_afs_version).to be_nil
    end
  end
end
