# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

class win_mozilla_build::custom_win32_python_3_7_2 (
    String $source,
    String $install_path
) {

$pkgdir = $facts['custom_win_temp_dir']



    file { "${$pkgdir}\\core.msi" :
        source => "${source}/core.msi",
    }
    package { 'python_3_7_3_win32_core' :
        ensure          => installed,
        source          => "${pkgdir}\\core.msi",
        install_options => ['InstallAllUsers=1', "TargetDir=${install_path}\\python3" ],
        require         => File["${pkgdir}\\core.msi"],
    }
}
