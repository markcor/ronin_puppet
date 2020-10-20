# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

# Using noma4i/windows_updates
# From https://forge.puppet.com/noma4i/windows_updates
# This is for individual KB updates
# If we want to do full patching we should use
# https://github.com/albatrossflavour/puppet_os_patching

class roles_profiles::profiles::microsoft_updates {

    case $::operatingsystem {
        'Windows': {
            # https://bugzilla.mozilla.org/show_bug.cgi?id=1671214
            windows_updates::kb {'KB4580328':
                ensure => 'present'
            }

        }
        default: {
            fail("${::operatingsystem} not supported")
        }
    }
}
