# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class win_os_settings::high_performance_reg {


    # Using puppetlabs-registry
    # Specifically for ARM64
    # others use windows::power_scheme ensure => 'High performance'

    $key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\explorer\ControlPanel\NameSpace'
    $namespace = '{025A5937-A6BE-4686-A844-36FE4BEC8B6D}'

    registry::value { 'LocalDumps' :
        key  => "${key}\\${namespace}",
        type => string,
        data => '8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c',
    }
}
