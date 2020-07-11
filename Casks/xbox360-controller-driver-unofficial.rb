cask 'xbox360-controller-driver-unofficial' do
  version '1.0.0-alpha.6'
  sha256 '32feb7d0b446a59292cae63ef8acebc5748855d021b459b6490a5af220b9a4d6'

  url "https://github.com/360Controller/360Controller/releases/download/v#{version}/360ControllerInstall_#{version}.dmg"
  appcast 'https://github.com/360Controller/360Controller/releases.atom'
  name 'TattieBogle Xbox 360 Controller Driver (with improvements)'
  homepage 'https://github.com/360Controller/360Controller'

  depends_on macos: '>= :el_capitan'

  pkg 'Install360Controller.pkg'

  uninstall launchctl: 'com.mice.360Daemon',
            quit:      'com.mice.-60Daemon', # '-60' is not a typo.
            kext:      [
                         'com.mice.Xbox360ControllerForceFeedback',
                         'com.mice.driver.Xbox360Controller',
                         'com.mice.driver.Wireless360Controller',
                         'com.mice.driver.WirelessGamingReceiver',
                       ],
            pkgutil:   'com.mice.pkg.Xbox360controller',
            # Symlink to kext in /Library/Extensions is not removed
            # during :pkgutil phase of uninstall, so we delete it here.
            delete:    '/System/Library/Extensions/360Controller.kext'

  caveats do
    reboot
  end
end
